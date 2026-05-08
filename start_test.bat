@echo off
cd /d C:\xampp\htdocs\new project
start "PHP Server" cmd /c "C:\xampp\php\php.exe -S localhost:8080 C:\xampp\htdocs\new project\router.php"
echo Server started on http://localhost:8080
echo.
echo Testing API endpoint...
timeout /t 2 /nobreak
curl -s -X POST "http://localhost:8080/auth/login" -H "Content-Type: application/json" -d "{\"email\":\"admin@example.com\",\"password\":\"admin123\"}"
echo.
pause