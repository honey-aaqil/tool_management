@echo off
cd /d C:\xampp\htdocs\new project

REM Kill any existing PHP processes on port 8080
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080" ^| findstr "LISTENING"') do (
    taskkill /F /PID %%a >nul 2>&1
)

timeout /t 2 /nobreak >nul

REM Start PHP server with correct syntax
start "PHP Server" cmd /c "C:\xampp\php\php.exe -S localhost:8080 C:\xampp\htdocs\new project\router.php"

timeout /t 3 /nobreak >nul

echo Server started at http://localhost:8080
pause