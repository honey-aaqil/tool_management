<?php
/**
 * Migration script to fix encrypted data after key format change
 * Run once: php backend/migrate_encryption.php
 */

require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/middleware/security.php';

echo "=== Encryption Migration Script ===\n\n";

// Read the hex key
$privateDir = dirname(__DIR__) . '/private';
$keyFile = $privateDir . '/encryption.key';

if (!file_exists($keyFile)) {
    die("Key file not found at: $keyFile\n");
}

$hexKey = trim(file_get_contents($keyFile));
echo "Key length (hex): " . strlen($hexKey) . " chars\n";

// Both key formats
$oldKey = $hexKey;  // 64-byte hex string (old method)
$newKey = hex2bin($hexKey);  // 32-byte binary (new method)
echo "Old key length: " . strlen($oldKey) . " bytes\n";
echo "New key length: " . strlen($newKey) . " bytes\n\n";

// Get all encrypted data from email_settings
$stmt = $pdo->query("SELECT id, smtp_password_encrypted FROM email_settings");
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo "Found " . count($rows) . " rows in email_settings\n\n";

$migrated = 0;
$failed = 0;

foreach ($rows as $row) {
    $id = $row['id'];
    $encryptedData = $row['smtp_password_encrypted'];
    
    if (empty($encryptedData)) {
        echo "Row $id: No encrypted data, skipping\n";
        continue;
    }
    
    echo "Row $id: Trying to decrypt... ";
    
    $decoded = base64_decode($encryptedData);
    if (strlen($decoded) < 32) {
        echo "Invalid data format, skipping\n";
        $failed++;
        continue;
    }
    
    $iv = substr($decoded, 0, 16);
    $ciphertext = substr($decoded, 16);
    
    $password = false;
    
    // Try NEW method first (32-byte binary key)
    $result = openssl_decrypt($ciphertext, 'aes-256-cbc', $newKey, 0, $iv);
    if ($result !== false) {
        $password = $result;
        echo "SUCCESS (new method)... ";
    } else {
        // Try OLD method (64-byte hex string as key)
        $result = openssl_decrypt($ciphertext, 'aes-256-cbc', $oldKey, 0, $iv);
        if ($result !== false) {
            $password = $result;
            echo "SUCCESS (old method)... ";
        }
    }
    
    if ($password === false) {
        echo "FAILED (both methods)\n";
        $failed++;
        continue;
    }
    
    echo "Got password: " . substr($password, 0, 3) . "*** ... ";
    
    // Re-encrypt with NEW method
    $newIv = random_bytes(16);
    $newEncrypted = openssl_encrypt($password, 'aes-256-cbc', $newKey, 0, $newIv);
    $newData = base64_encode($newIv . $newEncrypted);
    
    $updateStmt = $pdo->prepare("UPDATE email_settings SET smtp_password_encrypted = ? WHERE id = ?");
    $updateStmt->execute([$newData, $id]);
    
    echo "MIGRATED\n";
    $migrated++;
}

echo "\n=== Migration Complete ===\n";
echo "Migrated: $migrated\n";
echo "Failed: $failed\n";
