@echo off
REM CatLock Build Script for Windows
REM This script builds a local executable that won't be blocked by SmartScreen

echo ========================================
echo CatLock Build Script
echo ========================================
echo.

REM Check if Python is installed
    REM Set PYTHON312 to the path of your Python 3.12 installation
    set "PYTHON312=C:\Users\TimWarner\AppData\Local\Programs\Python\Python312\python.exe"

    REM Check if Python 3.12 is installed
    "%PYTHON312%" --version >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Python 3.12 is not installed at %PYTHON312%
        echo Please install Python 3.12 from https://www.python.org/downloads/
        pause
        exit /b 1
    )

echo [1/3] Installing dependencies...
    "%PYTHON312%" -m pip install -r requirements.txt
    if errorlevel 1 (
        echo ERROR: Failed to install dependencies
        pause
        exit /b 1
    )

echo.
echo [2/3] Installing PyInstaller...
    "%PYTHON312%" -m pip install pyinstaller
    if errorlevel 1 (
        echo ERROR: Failed to install PyInstaller
        pause
        exit /b 1
    )

echo.
echo [3/3] Building CatLock executable...
    "%PYTHON312%" -m pyinstaller --onefile ^
        --add-data="./resources/img/icon.ico;./resources/img/" ^
        --add-data="./resources/img/icon.png;./resources/img/" ^
        --add-data="./resources/config/config.json;./resources/config/" ^
        --icon="./resources/img/icon.ico" ^
        --hidden-import plyer.platforms.win.notification ^
        --noconsole ^
        --name="CatLock" ^
        "./src/main.py"

if errorlevel 1 (
    echo ERROR: Build failed
    pause
    exit /b 1
)

echo.
echo ========================================
echo BUILD SUCCESSFUL!
echo ========================================
echo.
echo Your executable is located at:
echo   dist\CatLock.exe
echo.
echo TIP: If Windows Defender flags it, add the dist folder
echo      to your exclusions list in Windows Security.
echo.
pause
