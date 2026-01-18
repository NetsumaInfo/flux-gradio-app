@echo off
setlocal enabledelayedexpansion

set "VENV_DIR=venv"

echo.
echo ========================================
echo   FLUX.2-klein-4B Image Generator
echo   Installation Script v2.0
echo ========================================
echo.
echo This script will install all dependencies needed
echo for AI image generation with FLUX.2-klein-4B
echo.

REM ============================================
REM   PRE-INSTALLATION CHECKS
REM ============================================

echo [CHECK] Verifying Python installation...
python --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo [ERROR] Python is not installed or not in PATH!
    echo.
    echo Please install Python 3.10 or 3.11 from:
    echo https://www.python.org/downloads/
    echo.
    echo Make sure to check "Add Python to PATH" during installation!
    echo.
    pause
    exit /b 1
)

python --version
echo.

REM Check Python version
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
for /f "tokens=1,2 delims=." %%a in ("!PYTHON_VERSION!") do (
    set PYTHON_MAJOR=%%a
    set PYTHON_MINOR=%%b
)

if !PYTHON_MAJOR! LSS 3 (
    echo [ERROR] Python 3.10 or 3.11 is required. You have Python !PYTHON_VERSION!
    echo Please install Python 3.10 or 3.11
    pause
    exit /b 1
)

if !PYTHON_MINOR! LSS 10 (
    echo [ERROR] Python 3.10 or 3.11 is required. You have Python !PYTHON_VERSION!
    echo Please install Python 3.10 or 3.11
    pause
    exit /b 1
)

if !PYTHON_MINOR! GTR 11 (
    echo [WARNING] Python 3.10 or 3.11 is recommended. You have Python !PYTHON_VERSION!
    echo Installation will continue but may have compatibility issues.
    timeout /t 3 >nul
)

echo [OK] Python !PYTHON_VERSION! detected
echo.

REM Check for Git
echo [CHECK] Verifying Git installation...
git --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo [ERROR] Git is not installed or not in PATH!
    echo.
    echo Git is required to install Diffusers library.
    echo Please install Git from:
    echo https://git-scm.com/downloads
    echo.
    echo Use default settings during installation.
    echo After installing, restart your computer and run this script again.
    echo.
    pause
    exit /b 1
)

git --version
echo [OK] Git detected
echo.

REM Check for NVIDIA GPU
echo [CHECK] Checking for NVIDIA GPU...
nvidia-smi >nul 2>&1
if errorlevel 1 (
    echo.
    echo [WARNING] nvidia-smi not found!
    echo.
    echo If you have an NVIDIA GPU:
    echo   - Install latest drivers from: https://www.nvidia.com/drivers
    echo   - This will enable GPU acceleration (10x faster!)
    echo.
    echo If you don't have an NVIDIA GPU:
    echo   - The app will run on CPU (slower but works)
    echo.
    set GPU_HARDWARE=0
) else (
    echo.
    nvidia-smi --query-gpu=name,driver_version,memory.total --format=csv,noheader
    echo.
    echo [OK] NVIDIA GPU detected!
    set GPU_HARDWARE=1
)

echo.
echo ========================================
echo   Starting Installation
echo ========================================
echo.
echo This will take 10-30 minutes depending on your internet speed.
echo The script will download approximately 10GB of data.
echo.
pause

REM ============================================
REM   INSTALLATION STEPS
REM ============================================

REM Create or verify virtual environment
if not exist "%VENV_DIR%" (
    echo.
    echo [1/9] Creating virtual environment...
    python -m venv "%VENV_DIR%"
    if errorlevel 1 (
        echo [ERROR] Failed to create virtual environment!
        pause
        exit /b 1
    )
    echo [OK] Virtual environment created
) else (
    echo.
    echo [1/9] Virtual environment already exists
    echo If you want a fresh install, delete the 'venv' folder first
)

echo.
echo [2/9] Activating virtual environment...
call "%VENV_DIR%\Scripts\activate.bat"
if errorlevel 1 (
    echo [ERROR] Failed to activate virtual environment!
    pause
    exit /b 1
)
echo [OK] Virtual environment activated

echo.
echo [3/9] Upgrading pip...
python -m pip install --upgrade pip --quiet
echo [OK] pip upgraded

echo.
echo [4/9] Installing PyTorch with CUDA 12.4 support...
echo This is the largest download (~2-3GB) and may take several minutes...
echo.
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
if errorlevel 1 (
    echo.
    echo [ERROR] Failed to install PyTorch!
    echo Check your internet connection and try again.
    pause
    exit /b 1
)
echo.
echo [OK] PyTorch installed

echo.
echo [5/9] Installing Gradio (web interface)...
pip install gradio --quiet
if errorlevel 1 (
    echo [ERROR] Failed to install Gradio!
    pause
    exit /b 1
)
echo [OK] Gradio installed

echo.
echo [6/9] Installing Transformers and Accelerate...
pip install transformers accelerate --quiet
echo [OK] Transformers installed

echo.
echo [7/9] Installing additional dependencies...
pip install sentencepiece protobuf --quiet
echo [OK] Additional dependencies installed

echo.
echo [8/9] Installing Diffusers from GitHub...
echo This includes support for FLUX.2-klein-4B...
pip install git+https://github.com/huggingface/diffusers.git --quiet
if errorlevel 1 (
    echo.
    echo [ERROR] Failed to install Diffusers!
    echo Make sure git is installed: https://git-scm.com/downloads
    pause
    exit /b 1
)
echo [OK] Diffusers installed

echo.
echo [9/9] Cleaning up incompatible packages...
pip uninstall -y xformers >nul 2>&1
echo [OK] Removed xformers (not compatible with Windows)
echo The app will use PyTorch's native Flash Attention instead

REM ============================================
REM   VERIFY CUDA INSTALLATION
REM ============================================

echo.
echo ========================================
echo   Verifying Installation
echo ========================================
echo.

echo Checking PyTorch and CUDA...
python -c "import torch; cuda_available = torch.cuda.is_available(); print(f'PyTorch version: {torch.__version__}'); print(f'CUDA available: {cuda_available}'); print(f'Device: {torch.cuda.get_device_name(0) if cuda_available else \"CPU (no GPU detected)\"}')"
echo.

REM Check if CUDA is available in PyTorch
python -c "import torch; exit(0 if torch.cuda.is_available() else 1)" >nul 2>&1
set CUDA_WORKING=!errorlevel!

if !CUDA_WORKING! NEQ 0 (
    if !GPU_HARDWARE! EQU 1 (
        echo.
        echo ========================================
        echo   CUDA Fix Required
        echo ========================================
        echo.
        echo [PROBLEM] You have an NVIDIA GPU but PyTorch cannot use it!
        echo This happens when PyTorch installs the CPU version instead of CUDA version.
        echo.
        echo [SOLUTION] Reinstalling PyTorch with CUDA support...
        echo.
        pause

        echo Uninstalling CPU-only PyTorch...
        pip uninstall torch torchvision torchaudio -y

        echo.
        echo Reinstalling PyTorch with CUDA 12.4...
        pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124

        echo.
        echo Verifying CUDA again...
        python -c "import torch; cuda_available = torch.cuda.is_available(); print(f'\nPyTorch version: {torch.__version__}'); print(f'CUDA available: {cuda_available}'); print(f'Device: {torch.cuda.get_device_name(0) if cuda_available else \"CPU\"}')"

        python -c "import torch; exit(0 if torch.cuda.is_available() else 1)" >nul 2>&1
        if errorlevel 1 (
            echo.
            echo [WARNING] CUDA still not working after reinstall.
            echo.
            echo Possible causes:
            echo 1. NVIDIA drivers not installed or outdated
            echo 2. GPU not compatible with CUDA 12.4
            echo.
            echo Please:
            echo 1. Update NVIDIA drivers: https://www.nvidia.com/drivers
            echo 2. Restart your computer
            echo 3. Run this script again
            echo.
            echo The app will work on CPU mode (slower).
        ) else (
            echo.
            echo [SUCCESS] CUDA is now working!
        )
    )
)

REM ============================================
REM   DOWNLOAD MODEL
REM ============================================

echo.
echo ========================================
echo   Downloading AI Model
echo ========================================
echo.
echo The FLUX.2-klein-4B model (~8GB) will now be downloaded.
echo This only happens once and may take 10-30 minutes.
echo.
echo You can skip this and download it later on first run.
echo.
choice /c YN /m "Download model now"
if errorlevel 2 (
    echo.
    echo [SKIPPED] Model download
    echo The model will be downloaded automatically when you first run the app.
    goto :skip_model
)

echo.
echo Downloading model... Please wait...
python -c "from diffusers import Flux2KleinPipeline; import torch; print('Connecting to Hugging Face...'); dtype = torch.bfloat16 if torch.cuda.is_available() else torch.float32; pipe = Flux2KleinPipeline.from_pretrained('black-forest-labs/FLUX.2-klein-4B', torch_dtype=dtype); print('\n✓ Model downloaded successfully!')"
if errorlevel 1 (
    echo.
    echo [WARNING] Model download failed or was interrupted.
    echo The model will be downloaded when you first run the app.
) else (
    echo [OK] Model is ready to use!
)

:skip_model

REM ============================================
REM   FINAL SUMMARY
REM ============================================

echo.
echo ========================================
echo   Installation Complete!
echo ========================================
echo.

REM Final CUDA check
python -c "import torch; exit(0 if torch.cuda.is_available() else 1)" >nul 2>&1
if errorlevel 1 (
    echo [STATUS] Running in CPU mode
    echo.
    echo Performance: Images will take 1-3 minutes to generate
    echo.
    if !GPU_HARDWARE! EQU 1 (
        echo [ACTION NEEDED] You have an NVIDIA GPU but it's not being used!
        echo.
        echo To fix:
        echo 1. Install NVIDIA drivers: https://www.nvidia.com/drivers
        echo 2. Restart your computer
        echo 3. Run this script again
        echo.
    ) else (
        echo [INFO] No NVIDIA GPU detected
        echo This is normal if you don't have a dedicated graphics card.
        echo The app will work fine, just slower.
        echo.
    )
) else (
    for /f "delims=" %%g in ('python -c "import torch; print(torch.cuda.get_device_name(0))"') do set GPU_NAME=%%g
    echo [STATUS] GPU Acceleration ENABLED
    echo GPU: !GPU_NAME!
    echo.
    echo Performance: Images will take 5-30 seconds to generate
    echo.
)

echo ========================================
echo.
echo To start the application:
echo   Double-click: run.bat
echo.
echo For a complete guide, read:
echo   GUIDE_INSTALLATION.md (French)
echo   README.md (English)
echo.
echo ========================================
pause
