<?php
/**
 * Temporary script to reset SMTP password
 * Access: http://localhost:8080/backend/reset_smtp.php
 * DELETE after use!
 */

require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/middleware/security.php';

echo "<h2>SMTP Password Reset</h2>";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $password = $_POST['password'] ?? '';
    
    if (empty($password)) {
        echo "<p style='color:red'>Password cannot be empty!</p>";
    } else {
        $encrypted = Security::encrypt($password);
        
        $stmt = $pdo->prepare("UPDATE email_settings SET smtp_password_encrypted = ? WHERE id = 1");
        $stmt->execute([$encrypted]);
        
        echo "<p style='color:green'>SMTP password updated successfully!</p>";
        echo "<p>New encrypted value: " . substr($encrypted, 0, 30) . "...</p>";
        
        // Test decryption
        try {
            $decrypted = Security::decrypt($encrypted);
            echo "<p style='color:green'>Test decryption: SUCCESS!</p>";
        } catch (Exception $e) {
            echo "<p style='color:red'>Test decryption failed: " . $e->getMessage() . "</p>";
        }
    }
}

// Show current config
$stmt = $pdo->query("SELECT smtp_host, smtp_username, from_email FROM email_settings WHERE id = 1");
$config = $stmt->fetch(PDO::FETCH_ASSOC);

echo "<h3>Current SMTP Config:</h3>";
echo "<p><strong>Host:</strong> " . ($config['smtp_host'] ?: 'Not set') . "</p>";
echo "<p><strong>Username:</strong> " . ($config['smtp_username'] ?: 'Not set') . "</p>";
echo "<p><strong>From Email:</strong> " . ($config['from_email'] ?: 'Not set') . "</p>";
?>

<form method="POST">
    <p>
        <label>New SMTP Password:<br>
        <input type="password" name="password" style="width:300px; padding:5px;" required>
        </label>
    </p>
    <p>
        <button type="submit" style="padding:10px 20px; background:#007bff; color:white; border:none; cursor:pointer;">
            Update SMTP Password
        </button>
    </p>
</form>

<p><em>After updating, test signup and delete this file!</em></p>
