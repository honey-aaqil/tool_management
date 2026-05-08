@echo off
REM Tool Management - Persistent PHP Server
REM This script keeps the PHP server running even if closed

cd /d "C:\xampp\htdocs\new project"

echo ============================================
echo Starting Tool Management Server...
echo ============================================
echo.

:start_server
echo [%time%] Starting PHP server on port 8080...
start /b "PHP Server" cmd /c "C:\xampp\php\php.exe -S localhost:8080 C:\xampp\htdocs\new project\router.php"
timeout /t 2 /nobreak >nul

echo Server started! Access at: http://localhost:8080
echo.
echo To stop the server, close this window or press Ctrl+C
echo ============================================

REM Keep the window open and check if server is still running
:check
timeout /t 5 /nobreak >nul
netstat -ano | findstr ":8080" | findstr "LISTENING" >nul
if %errorlevel% neq 0 (
    echo [%time%] Server stopped! Restarting...
    goto start_server
)
goto check