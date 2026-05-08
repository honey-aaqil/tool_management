<?php
/**
 * Fix SMTP password encryption
 * Run: php backend/fix_smtp_password.php
 */

require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/middleware/security.php';

echo "=== SMTP Password Fix ===\n\n";

// Get current encrypted password
$stmt = $pdo->query("SELECT smtp_password_encrypted FROM email_settings WHERE id = 1");
$row = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$row) {
    die("No email settings found for id=1\n");
}

echo "Current encrypted password: " . substr($row['smtp_password_encrypted'], 0, 20) . "...\n\n";

// Try to decrypt with both methods
$decoded = base64_decode($row['smtp_password_encrypted']);
$iv = substr($decoded, 0, 16);
$ciphertext = substr($decoded, 16);

// Get key
$privateDir = dirname(__DIR__) . '/private';
$keyFile = $privateDir . '/encryption.key';
$hexKey = trim(file_get_contents($keyFile));

// Try new method (32-byte binary)
$newKey = hex2bin($hexKey);
$result = openssl_decrypt($ciphertext, 'aes-256-cbc', $newKey, OPENSSL_RAW_DATA, $iv);

if ($result !== false) {
    echo "SUCCESS: Password decrypted with NEW method\n";
    $password = $result;
} else {
    // Try old method (64-byte hex string)
    $oldKey = $hexKey;
    $result = openssl_decrypt($ciphertext, 'aes-256-cbc', $oldKey, OPENSSL_RAW_DATA, $iv);
    
    if ($result !== false) {
        echo "SUCCESS: Password decrypted with OLD method\n";
        $password = $result;
    } else {
        die("FAILED: Cannot decrypt password. Please re-enter SMTP password in admin panel.\n");
    }
}

echo "Decrypted password: " . substr($password, 0, 3) . "***\n\n";

// Re-encrypt with correct method (32-byte binary key)
$newIv = random_bytes(16);
$newEncrypted = openssl_encrypt($password, 'aes-256-cbc', $newKey, OPENSSL_RAW_DATA, $newIv);
$newData = base64_encode($newIv . $newEncrypted);

// Update database
$updateStmt = $pdo->prepare("UPDATE email_settings SET smtp_password_encrypted = ? WHERE id = 1");
$updateStmt->execute([$newData]);

echo "Password re-encrypted and updated successfully!\n";
echo "New encrypted value: " . substr($newData, 0, 20) . "...\n\n";
echo "=== DONE ===\n";
