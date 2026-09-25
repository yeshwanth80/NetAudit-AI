@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title NetAudit AI - Backend + Local UI

set "VENV_PY=backend\.venv\Scripts\python.exe"

if not exist "%VENV_PY%" (
  echo [1/4] Creating Python virtual environment...
  py -3 -m venv backend\.venv
  if errorlevel 1 (
    echo.
    echo ERROR: Python 3 was not found through the Windows 'py' launcher.
    echo Install Python 3.10+ from python.org and make sure the Python Launcher is installed.
    pause
    exit /b 1
  )
)

rem IMPORTANT: Do not assume an existing .venv already contains FastAPI.
rem This fixes the previous ModuleNotFoundError: No module named 'fastapi'.
echo [2/4] Checking backend dependencies...
"%VENV_PY%" -c "import fastapi, uvicorn" >nul 2>&1
if errorlevel 1 (
  echo FastAPI/Uvicorn are missing. Installing them now...
  "%VENV_PY%" -m pip install --upgrade pip
  if errorlevel 1 goto :pipfail
  "%VENV_PY%" -m pip install -r backend\requirements.txt
  if errorlevel 1 goto :pipfail
)

"%VENV_PY%" -c "import fastapi, uvicorn; print('FastAPI and Uvicorn: OK')"
if errorlevel 1 goto :pipfail

echo [3/4] Starting NetAudit AI backend on http://127.0.0.1:8000 ...
start "NetAudit AI Backend" cmd /k "cd /d %~dp0backend && .venv\Scripts\python.exe main.py"

timeout /t 2 /nobreak >nul

echo Starting local frontend on http://127.0.0.1:3000 ...
start "NetAudit AI Frontend" cmd /k "cd /d %~dp0frontend && py -3 -m http.server 3000 --bind 127.0.0.1"

timeout /t 2 /nobreak >nul
start "" "http://127.0.0.1:3000/index.html"

echo [4/4] NetAudit AI is running.
echo.
echo ================================================
echo Frontend: http://127.0.0.1:3000/index.html
echo Backend : http://127.0.0.1:8000/docs
echo Health  : http://127.0.0.1:8000/api/v1/health
echo ================================================
echo.
echo Keep both command windows open while using the prototype.
echo Use STOP_NETAUDIT_AI.bat when finished.
echo.
pause
endlocal
exit /b 0

:pipfail
echo.
echo ERROR: Backend dependencies could not be installed.
echo Try running this file again after confirming that the PC has internet access.
echo The required packages are listed in backend\requirements.txt.
echo.
pause
endlocal
exit /b 1
