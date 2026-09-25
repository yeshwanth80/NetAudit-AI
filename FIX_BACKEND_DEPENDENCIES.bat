@echo off
setlocal
cd /d "%~dp0"
title NetAudit AI - Fix Backend Dependencies

if not exist "backend\.venv\Scripts\python.exe" (
  echo Creating virtual environment...
  py -3 -m venv backend\.venv
  if errorlevel 1 (
    echo Python 3 was not found.
    pause
    exit /b 1
  )
)

echo Installing FastAPI and Uvicorn...
backend\.venv\Scripts\python.exe -m pip install --upgrade pip
backend\.venv\Scripts\python.exe -m pip install -r backend\requirements.txt
if errorlevel 1 (
  echo.
  echo INSTALLATION FAILED. Check internet access and try again.
  pause
  exit /b 1
)

echo.
echo SUCCESS: Backend dependencies are installed.
echo You can now run RUN_NETAUDIT_AI.bat
pause
endlocal
