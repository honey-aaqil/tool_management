<?php
/**
 * Get Email Settings
 */

require_once __DIR__ . '/../middleware/CorsMiddleware.php';
CorsMiddleware::handle();
header('Content-Type: application/json');

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../middleware/security.php';

Security::initSession();

if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Please login first']);
    exit;
}

try {
    $tableExists = $pdo->query("SHOW TABLES LIKE 'email_settings'")->rowCount() > 0;
    
    if (!$tableExists) {
        $pdo->exec("CREATE TABLE IF NOT EXISTS email_settings (
            id INT AUTO_INCREMENT PRIMARY KEY,
            smtp_host VARCHAR(255) DEFAULT 'smtp.gmail.com',
            smtp_port INT DEFAULT 587,
            smtp_username VARCHAR(255) DEFAULT '',
            smtp_password_encrypted VARCHAR(512) DEFAULT '',
            from_email VARCHAR(255) DEFAULT '',
            from_name VARCHAR(255) DEFAULT 'Tool Management System',
            notification_email VARCHAR(255) DEFAULT '',
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )");
        
        $pdo->exec("INSERT INTO email_settings (id) VALUES (1)");
    }
    
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        $stmt = $pdo->query("SELECT id, smtp_host, smtp_port, smtp_username, smtp_password, smtp_password_encrypted, from_email, from_name, notification_email FROM email_settings WHERE id = 1");
        $settings = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$settings) {
            $pdo->exec("INSERT INTO email_settings (id) VALUES (1)");
            $stmt = $pdo->query("SELECT id, smtp_host, smtp_port, smtp_username, smtp_password, smtp_password_encrypted, from_email, from_name, notification_email FROM email_settings WHERE id = 1");
            $settings = $stmt->fetch(PDO::FETCH_ASSOC);
        }
        
        // Decrypt password for display (masked)
        $settings['smtp_password'] = '';
        if (!empty($settings['smtp_password_encrypted'])) {
            try {
                $decrypted = Security::decrypt($settings['smtp_password_encrypted']);
                if ($decrypted && strlen($decrypted) > 0) {
                    $settings['smtp_password'] = str_repeat('*', min(strlen($decrypted), 12));
                    $settings['has_password'] = true;
                }
            } catch (Exception $e) {
                // Password might be stored as plain text - treat as has_password
                $settings['has_password'] = true;
                $settings['smtp_password'] = '************';
            }
        }
        
        unset($settings['smtp_password_encrypted']);
        
        echo json_encode([
            'success' => true,
            'settings' => $settings
        ]);
        exit;
    }
    
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $csrfToken = $_SERVER['HTTP_X_CSRF_TOKEN'] ?? '';
        if (!Security::validateCsrfToken($csrfToken)) {
            http_response_code(403);
            echo json_encode(['error' => 'Invalid CSRF token']);
            exit;
        }
        
        // Check admin without exiting - just for debugging
        if (!Security::isAdmin()) {
            http_response_code(403);
            echo json_encode(['error' => 'Admin access required', 'debug' => 'Not admin user']);
            exit;
        }
        
        $data = json_decode(file_get_contents('php://input'), true);
        
        $smtpHost = $data['smtp_host'] ?? 'smtp.gmail.com';
        $smtpPort = isset($data['smtp_port']) ? (int)$data['smtp_port'] : 587;
        $smtpUsername = $data['smtp_username'] ?? '';
        $smtpPassword = $data['smtp_password'] ?? '';
        $fromEmail = $data['from_email'] ?? '';
        $fromName = $data['from_name'] ?? 'Tool Management System';
        $notificationEmail = $data['notification_email'] ?? '';
        
        if (empty($fromEmail)) {
            http_response_code(400);
            echo json_encode(['error' => 'From email is required']);
            exit;
        }
        
        // Encrypt password before storing - allow any length password
        $encryptedPassword = '';
        try {
            if (!empty($smtpPassword)) {
                $encryptedPassword = Security::encrypt($smtpPassword);
                if ($encryptedPassword === false) {
                    error_log('Encryption failed for password');
                }
            }
        } catch (Exception $e) {
            error_log('Encryption error: ' . $e->getMessage());
        }
        
        $stmt = $pdo->prepare("UPDATE email_settings SET smtp_host = ?, smtp_port = ?, smtp_username = ?, smtp_password_encrypted = ?, from_email = ?, from_name = ?, notification_email = ? WHERE id = 1");
        $stmt->execute([$smtpHost, $smtpPort, $smtpUsername, $encryptedPassword, $fromEmail, $fromName, $notificationEmail]);
        
        echo json_encode([
            'success' => true,
            'message' => 'Email settings saved successfully'
        ]);
        
        require_once __DIR__ . '/../middleware/AuditLogger.php';
        AuditLogger::log('email_settings_updated', [
            'smtp_host' => $smtpHost,
            'from_email' => $fromEmail
        ], $_SESSION['user_id'], $_SESSION['user_email']);
        
        exit;
    }
    
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    
} catch (Exception $e) {
    error_log('getEmailSettings error: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => 'Failed to process request. Please try again later.'
    ]);
}
