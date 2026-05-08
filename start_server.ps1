$ErrorActionPreference = "SilentlyContinue"
$phpPath = "C:\xampp\php\php.exe"
$rootPath = "C:\xampp\htdocs\new project"
$routerPath = "C:\xampp\htdocs\new project\router.php"
$port = 8080

# Kill existing processes
Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue | ForEach-Object { 
    Stop-Process -Id $_.OwningProcess -Force -ErrorAction SilentlyContinue 
}
Start-Sleep -Seconds 2

# Start PHP server
$process = Start-Process -FilePath $phpPath -ArgumentList "-S localhost:$port -t `"$rootPath`" `"$routerPath`"" -WindowStyle Hidden -PassThru
Start-Sleep -Seconds 3

# Check if running
if ($process.HasExited) {
    Write-Host "Server failed to start"
    exit 1
} else {
    Write-Host "Server running at http://localhost:$port"
    Write-Host "PID: $($process.Id)"
}