@echo off
echo ============================================
echo Starting Tool Management System
echo ============================================
echo.
echo Starting PHP server on port 8080...
cd /d C:\xampp\htdocs\new project
start "PHP Server" cmd /c "C:\xampp\php\php.exe -S localhost:8080 C:\xampp\htdocs\new project\router.php"
echo Waiting for server to start...
timeout /t 3 /nobreak >nul
echo.
echo Opening browser...
start http://localhost:8080
echo.
echo ============================================
echo System is running at: http://localhost:8080
echo.
echo Login: admin@example.com / admin123
echo ============================================
echo.
pause