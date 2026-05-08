<?php
/**
 * SMTP Config Helper - Get SMTP settings without authentication
 * Used by signup and other public endpoints
 */

require_once __DIR__ . '/../config/db.php';

function getSmtpConfig() {
    global $pdo;
    try {
        $tableExists = $pdo->query("SHOW TABLES LIKE 'email_settings'")->rowCount() > 0;
        if (!$tableExists) {
            return ['smtp_host' => '', 'smtp_port' => 587, 'smtp_username' => '', 'smtp_password' => '', 'from_email' => '', 'from_name' => '', 'notification_email' => ''];
        }
        
        $stmt = $pdo->query("SELECT smtp_host, smtp_port, smtp_username, smtp_password_encrypted, smtp_password, from_email, from_name, notification_email FROM email_settings WHERE id = 1");
        $config = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$config) {
            return ['smtp_host' => '', 'smtp_port' => 587, 'smtp_username' => '', 'smtp_password' => '', 'from_email' => '', 'from_name' => '', 'notification_email' => ''];
        }
        
        $config = array_merge([
            'smtp_host' => '', 'smtp_port' => 587, 'smtp_username' => '', 'smtp_password' => '', 'from_email' => '', 'from_name' => '', 'notification_email' => ''
        ], $config);
        
        $password = '';
        if (!empty($config['smtp_password_encrypted'])) {
            require_once __DIR__ . '/../middleware/security.php';
            try {
                $password = Security::decrypt($config['smtp_password_encrypted']);
                if ($password === false || empty($password)) {
                    error_log('SMTP password decryption failed for config id=1');
                    $password = '';
                }
            } catch (Exception $e) {
                error_log('SMTP password decryption error: ' . $e->getMessage());
                $password = '';
            }
        }
        
        return [
            'smtp_host' => $config['smtp_host'] ?? 'smtp.gmail.com',
            'smtp_port' => (int)($config['smtp_port'] ?? 587),
            'smtp_username' => $config['smtp_username'] ?? '',
            'smtp_password' => $password,
            'from_email' => $config['from_email'] ?? '',
            'from_name' => $config['from_name'] ?? 'Tool Management System',
            'notification_email' => $config['notification_email'] ?? ''
        ];
    } catch (Exception $e) {
        error_log('getSmtpConfig error: ' . $e->getMessage());
        return ['smtp_host' => '', 'smtp_port' => 587, 'smtp_username' => '', 'smtp_password' => '', 'from_email' => '', 'from_name' => '', 'notification_email' => ''];
    }
}
