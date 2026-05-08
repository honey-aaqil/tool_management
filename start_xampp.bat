@echo off
echo ============================================
echo Tool Management System - XAMPP Server
echo ============================================
echo.

REM Check if XAMPP Apache is running
netstat -ano | findstr ":80" | findstr "LISTENING" >nul
if %errorlevel% neq 0 (
    echo WARNING: Apache may not be running on port 80
    echo Please start Apache in XAMPP Control Panel
    echo.
    echo Or try: cd C:\xampp\apache\bin && httpd.exe
    echo.
)

echo Starting application at: http://localhost
echo.
echo If page doesn't load, try:
echo 1. Start Apache in XAMPP Control Panel
echo 2. Or run this script as Administrator
echo.
pause