@echo off
setlocal

set "VENV_DIR=venv"

echo ========================================
echo   FLUX.2-klein-4B - Gradio App
echo ========================================
echo.

if not exist "%VENV_DIR%" (
    echo Virtual environment not found!
    echo Please run install.bat first.
    pause
    exit /b 1
)

echo Activating virtual environment...
call "%VENV_DIR%\Scripts\activate.bat"

echo Starting Gradio App...
echo.
python app.py

pause
