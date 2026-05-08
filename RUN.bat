@echo off
echo ============================================
echo Starting Tool Management Application
echo ============================================
echo.

REM Check MySQL
echo [1/4] Checking MySQL...
netstat -ano | findstr ":3306" | findstr "LISTENING" >nul
if %errorlevel% neq 0 (
    echo ERROR: MySQL not running!
    echo Please start Apache and MySQL in XAMPP Control Panel
    pause
    exit /b 1
)
echo OK - MySQL is running

REM Kill existing PHP server on 8080
echo.
echo [2/4] Checking port 8080...
netstat -ano | findstr ":8080" | findstr "LISTENING" >nul
if %errorlevel% equ 0 (
    echo Port 8080 in use, killing old process...
    for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080" ^| findstr "LISTENING"') do taskkill /F /PID %%a >nul 2>&1
    timeout /t 2 /nobreak >nul
)
echo OK - Port 8080 ready

REM Check frontend build exists
echo.
echo [3/4] Checking React build...
if not exist "frontend\build\index.html" (
    echo Building React app...
    cd frontend
    call npm run build
    cd ..
)
echo OK - React build ready

REM Start PHP server
echo.
echo [4/4] Starting PHP Server on http://localhost:8080
echo.
echo ============================================
echo Application ready!
echo.
echo Open this link in browser:
echo.
echo http://localhost:8080
echo.
echo NOTE: Use the credentials you set during signup
echo Or configure admin credentials via environment variables:
echo   DB_HOST, DB_USER, DB_PASS, ADMIN_PASSWORD
echo ============================================
echo.
echo Press Ctrl+C to stop the server
echo.

cd /d C:\xampp\htdocs\new project
C:\xampp\php\php.exe -S localhost:8080 C:\xampp\htdocs\new project\router.php