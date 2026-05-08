<?php
/**
 * Test Email using PHPMailer
 */

require_once __DIR__ . '/../middleware/CorsMiddleware.php';
CorsMiddleware::handle();
header('Content-Type: application/json');

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../middleware/security.php';
require_once __DIR__ . '/../PHPMailer/sendEmail.php';

Security::initSession();

if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Please login first']);
    exit;
}

Security::requireAdmin();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    exit;
}

$csrfToken = $_SERVER['HTTP_X_CSRF_TOKEN'] ?? '';
if (!Security::validateCsrfToken($csrfToken)) {
    http_response_code(403);
    echo json_encode(['error' => 'Invalid CSRF token']);
    exit;
}

$data = json_decode(file_get_contents('php://input'), true);
$email = isset($data['email']) ? trim($data['email']) : '';

if (empty($email)) {
    http_response_code(400);
    echo json_encode(['error' => 'Email address is required']);
    exit;
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid email format']);
    exit;
}

try {
    $stmt = $pdo->query("SELECT * FROM email_settings WHERE id = 1");
    $settings = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$settings) {
        http_response_code(400);
        echo json_encode(['error' => 'Please save email settings first']);
        exit;
    }

    // Decrypt password if stored encrypted
    $smtpPassword = '';
    if (!empty($settings['smtp_password_encrypted'])) {
        $smtpPassword = Security::decrypt($settings['smtp_password_encrypted']);
    } elseif (!empty($settings['smtp_password'])) {
        $smtpPassword = $settings['smtp_password'];
    }

    if (empty($settings['smtp_host']) || empty($settings['smtp_username']) || empty($smtpPassword)) {
        http_response_code(400);
        echo json_encode(['error' => 'SMTP not configured. Please save email settings with app password.']);
        exit;
    }

    $smtpSettings = [
        'smtp_host' => $settings['smtp_host'],
        'smtp_port' => (int)$settings['smtp_port'],
        'smtp_username' => $settings['smtp_username'],
        'smtp_password' => $smtpPassword,
        'from_email' => $settings['from_email'] ?: $settings['smtp_username'],
        'from_name' => $settings['from_name'] ?? 'Tool Management System'
    ];

    $mailer = new SendEmail($smtpSettings);
    $result = $mailer->sendTest($email);

    if ($result['success']) {
        require_once __DIR__ . '/../middleware/AuditLogger.php';
        AuditLogger::log('test_email_sent', ['sent_to' => $email], $_SESSION['user_id'], $_SESSION['user_email']);
        
        echo json_encode([
            'success' => true,
            'message' => 'Test email sent to ' . $email
        ]);
    } else {
        http_response_code(500);
        echo json_encode([
            'success' => false,
            'error' => $result['error']
        ]);
    }
} catch (Exception $e) {
    $errorMsg = $e->getMessage();
    if (empty($errorMsg)) {
        $errorMsg = 'Failed to send test email. Check SMTP settings and network connectivity.';
    }
    error_log('testEmail error: ' . $errorMsg);
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => $errorMsg
    ]);
}
