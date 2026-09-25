@echo off
taskkill /FI "WINDOWTITLE eq NetAudit AI Backend" /T /F >nul 2>&1
taskkill /FI "WINDOWTITLE eq NetAudit AI Frontend" /T /F >nul 2>&1
echo NetAudit AI backend and frontend stopped.
pause
