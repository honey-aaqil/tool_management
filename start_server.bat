@echo off
echo ============================================
echo Tool Management System - Starting
echo ============================================
echo.
echo Starting Apache server...
cd /d C:\xampp\apache
if not exist "pid.txt" (
    start "" bin\httpd.exe
    timeout /t 2 /nobreak >nul
)
echo.
echo Opening browser...
start http://localhost/
echo.
echo ============================================
echo System is running at: http://localhost/
echo.
echo Login: admin@example.com / admin123
echo ============================================
pause