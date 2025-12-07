@echo off
setlocal ENABLEDELAYEDEXPANSION

REM =============================
REM  Build script for TicTacToe3D client (.exe)
REM  Usage:
REM    build.bat [--console] [--icon icon.ico] [--name TicTacToe3D] [--serverURL https://your-url]
REM  Notes:
REM    - Run this script in the same folder where tictactoe3d_client.py lives.
REM    - If --serverURL is provided, it will patch SERVER_URL in tictactoe3d_client.py during the build.
REM =============================

REM Default values
set APP_NAME=TicTacToe3D
set ICON_ARG=
set CONSOLE_ARG=--noconsole
set SERVER_URL=

REM Parse arguments
:parse
if "%~1"=="" goto after_parse
if /I "%~1"=="--console" (
  set CONSOLE_ARG=--console
  shift
  goto parse
)
if /I "%~1"=="--icon" (
  set ICON_PATH=%~2
  if not exist "%ICON_PATH%" (
    echo [WARN] Icon file not found: %ICON_PATH%
  ) else (
    set ICON_ARG=--icon "%ICON_PATH%"
  )
  shift
  shift
  goto parse
)
if /I "%~1"=="--name" (
  set APP_NAME=%~2
  shift
  shift
  goto parse
)
if /I "%~1"=="--serverURL" (
  set SERVER_URL=%~2
  shift
  shift
  goto parse
)
shift
goto parse

after_parse:

REM Check Python
where python >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Python not found in PATH. Install Python from https://www.python.org/ and retry.
  goto end
)

REM Create venv
if not exist .venv (
  echo [INFO] Creating virtual environment .venv
  python -m venv .venv
)

REM Activate venv
call .venv\Scripts\activate

REM Upgrade pip
python -m pip install --upgrade pip

REM Install deps
if exist requirements.txt (
  echo [INFO] Installing from requirements.txt
  pip install -r requirements.txt
) else (
  echo [INFO] Installing required packages
  pip install "python-socketio[client]" pyinstaller
)

REM Optionally patch SERVER_URL in the client
if not "%SERVER_URL%"=="" (
  if exist tictactoe3d_client.py (
    echo [INFO] Patching SERVER_URL to %SERVER_URL%
    powershell -Command "(Get-Content 'tictactoe3d_client.py') -replace 'SERVER_URL\s*=\s*\"[^\"]*\"', 'SERVER_URL = \"%SERVER_URL%\"' | Set-Content 'tictactoe3d_client.py'"
  ) else (
    echo [WARN] tictactoe3d_client.py not found; skipping URL patch.
  )
)

REM Build
if not exist tictactoe3d_client.py (
  echo [ERROR] tictactoe3d_client.py not found in current directory.
  goto end
)

echo [INFO] Building %APP_NAME%.exe
pyinstaller --onefile %CONSOLE_ARG% %ICON_ARG% --name "%APP_NAME%" tictactoe3d_client.py

if exist dist\%APP_NAME%.exe (
  echo [SUCCESS] Build complete: dist\%APP_NAME%.exe
) else (
  echo [ERROR] Build failed. Check the output above for errors.
)

pause
:end
endlocal
