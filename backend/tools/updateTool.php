<?php
require_once __DIR__ . '/../middleware/CorsMiddleware.php';
CorsMiddleware::handle();
header('Content-Type: application/json');

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../middleware/security.php';
require_once __DIR__ . '/../middleware/AuditLogger.php';

Security::initSession();

if ($_SERVER['REQUEST_METHOD'] !== 'POST' && $_SERVER['REQUEST_METHOD'] !== 'PUT') {
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

Security::requireAuth();
Security::checkPermission(Security::PERM_EDIT_TOOLS);

// Admin only - users cannot update tools
if (!Security::isAdmin()) {
    http_response_code(403);
    echo json_encode(['error' => 'Permission denied. Admin access required to update tools.']);
    exit;
}

$data = json_decode(file_get_contents('php://input'), true);

$allowedCurrencies = ['USD', 'INR', 'MYR', 'AED', 'EUR', 'GBP', 'CAD'];
$allowedStatuses = ['Active', 'Inactive'];
$allowedFrequencies = ['Monthly', 'Quarterly', 'Annual'];
$allowedGeographies = ['USA', 'INDIA', 'CANADA', 'MALAYSIA', 'DUBAI', 'UK'];

$id = isset($data['id']) ? (int)$data['id'] : 0;
$year = isset($data['year']) ? (int)$data['year'] : date('Y');
$toolName = Security::sanitizeInput($data['tool_name'] ?? '');
$type = Security::sanitizeInput($data['type'] ?? 'NA');
$noOfLicense = isset($data['no_of_license']) ? (int)$data['no_of_license'] : 1;
$jobSlots = isset($data['job_slots']) ? (int)$data['job_slots'] : 0;
$resumeViews = isset($data['resume_views']) ? (int)$data['resume_views'] : 0;
$bulkMail = isset($data['bulk_mail']) ? (int)$data['bulk_mail'] : 0;
$cost = isset($data['cost']) ? (float)$data['cost'] : 0;
$revenue = isset($data['revenue']) ? (float)$data['revenue'] : 0;
$monthlyCost = isset($data['monthly_cost']) ? (float)$data['monthly_cost'] : 0;
$quarterlyCost = isset($data['quarterly_cost']) ? (float)$data['quarterly_cost'] : 0;
$annualCost = isset($data['annual_cost']) ? (float)$data['annual_cost'] : 0;
$currency = Security::sanitizeInput($data['currency'] ?? 'USD');
$geography = Security::sanitizeInput($data['geography'] ?? 'USA');
$paymentFrequency = Security::sanitizeInput($data['payment_frequency'] ?? 'Monthly');
$lastRenewal = Security::sanitizeInput($data['last_renewal'] ?? '');
$nextRenewal = Security::sanitizeInput($data['next_renewal'] ?? '');
$comments = Security::sanitizeInput($data['comments'] ?? '');
if (strlen($comments) > 1000) {
    http_response_code(400);
    echo json_encode(['error' => 'Comments too long (max 1000 characters)']);
    exit;
}
$spocInternal = Security::sanitizeInput($data['spoc_1'] ?? '');
if (strlen($spocInternal) > 255) {
    http_response_code(400);
    echo json_encode(['error' => 'SPOC 1 too long (max 255 characters)']);
    exit;
}
$spocExternal = Security::sanitizeInput($data['spoc_2'] ?? '');
if (strlen($spocExternal) > 255) {
    http_response_code(400);
    echo json_encode(['error' => 'SPOC 2 too long (max 255 characters)']);
    exit;
}
$contactNo = Security::sanitizeInput($data['contact_no'] ?? '');
if (strlen($contactNo) > 50) {
    http_response_code(400);
    echo json_encode(['error' => 'Contact number too long (max 50 characters)']);
    exit;
}
$emailId = Security::sanitizeInput($data['email_id'] ?? '');
if (strlen($emailId) > 255) {
    http_response_code(400);
    echo json_encode(['error' => 'Email ID too long (max 255 characters)']);
    exit;
}
$status = Security::sanitizeInput($data['status'] ?? 'Active');
$reasonForUsing = Security::sanitizeInput($data['reason_for_using'] ?? '');

if (!Security::validateRequired($toolName)) {
    http_response_code(400);
    echo json_encode(['error' => 'Tool name and ID are required']);
    exit;
}
if (strlen($toolName) > 255) {
    http_response_code(400);
    echo json_encode(['error' => 'Tool name too long (max 255 characters)']);
    exit;
}
if (strlen($type) > 100) {
    http_response_code(400);
    echo json_encode(['error' => 'Tool type too long (max 100 characters)']);
    exit;
}

if ($year < 2000 || $year > 2100) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid year']);
    exit;
}

if (!Security::validateEnum($currency, $allowedCurrencies)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid currency']);
    exit;
}

if (!Security::validateEnum($geography, $allowedGeographies)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid geography']);
    exit;
}

if (!Security::validateEnum($status, $allowedStatuses)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid status']);
    exit;
}

if (!Security::validateEnum($paymentFrequency, $allowedFrequencies)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid payment frequency']);
    exit;
}

if (!empty($emailId) && !Security::validateEmail($emailId)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid email format']);
    exit;
}

if (!empty($lastRenewal) && !Security::validateDate($lastRenewal)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid last renewal date format']);
    exit;
}

if (!empty($nextRenewal) && !Security::validateDate($nextRenewal)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid next renewal date format']);
    exit;
}

try {
    $stmt = $pdo->prepare("UPDATE tools SET 
        year = ?, tool_name = ?, type = ?, no_of_license = ?, job_slots = ?, resume_views = ?, bulk_mail = ?, cost = ?, revenue = ?, monthly_cost = ?, 
        quarterly_cost = ?, annual_cost = ?, currency = ?, geography = ?,
        payment_frequency = ?, last_renewal = ?, next_renewal = ?, comments = ?, 
        spoc_1 = ?, spoc_2 = ?, contact_no = ?, email_id = ?, 
        status = ?, reason_for_using = ?
    WHERE id = ?");
    
    $stmt->execute([
        $year, $toolName, $type, $noOfLicense, $jobSlots, $resumeViews, $bulkMail, $cost, $revenue, $monthlyCost, $quarterlyCost, $annualCost, $currency, $geography,
        $paymentFrequency, $lastRenewal, $nextRenewal,
        $comments, $spocInternal, $spocExternal, $contactNo, $emailId, $status, $reasonForUsing, $id
    ]);

    if ($stmt->rowCount() === 0) {
        http_response_code(404);
        echo json_encode(['error' => 'Tool not found']);
        exit;
    }
    
    AuditLogger::toolAction('updated', $id, $toolName, $_SESSION['user_id'] ?? null, $_SESSION['user_email'] ?? null);
    
    echo json_encode([
        'success' => true,
        'message' => 'Tool updated successfully'
    ]);
} catch (Exception $e) {
    error_log('updateTool error: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Failed to update tool']);
}
