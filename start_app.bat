@echo off
echo ============================================
echo Tool Management System
echo Frontend: React | Backend: PHP | DB: MySQL
echo ============================================
echo.

echo [1/3] Checking MySQL...
netstat -ano | findstr ":3306" | findstr "LISTENING" >nul
if %errorlevel% neq 0 (
    echo ERROR: MySQL not running. Please start Apache in XAMPP.
    pause
    exit /b 1
)
echo MySQL is running

echo.
echo [2/3] Killing old processes on port 8080...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080" ^| findstr "LISTENING"') do taskkill /F /PID %%a >nul 2>&1
timeout /t 1 /nobreak >nul

echo [3/3] Starting PHP Server on port 8080...
echo.
echo ============================================
echo Access the app at: http://localhost:8080
echo.
echo Login credentials:
echo   Email: admin@example.com
echo   Password: Admin@123
echo ============================================

cd /d C:\xampp\htdocs\new project
C:\xampp\php\php.exe -S localhost:8080 C:\xampp\htdocs\new project\router.php
