@echo off
cd /d C:\xampp\htdocs\new project
echo Starting PHP Server...
start /B cmd /c "C:\xampp\php\php.exe -S localhost:8080 C:\xampp\htdocs\new project\router.php > server.log 2>&1"
timeout /t 3 /nobreak >nul
echo Server started at http://localhost:8080
echo.
echo If it doesn't work, check server.log for errors
pause