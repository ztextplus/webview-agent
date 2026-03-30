@echo off
setlocal

set "EXE_NAME=zWebView2Agent.exe"

echo.
echo [1/4] Killing process: %EXE_NAME%
rem Kill process (ignore if not running)
taskkill /F /IM "%EXE_NAME%" >nul 2>&1
if "%ERRORLEVEL%"=="0" (
  echo - Killed (or terminated) successfully.
) else (
  echo - Not running or could not be terminated (continuing).
)

echo.
echo [2/4] Waiting 3 seconds...
rem Wait 3 seconds
timeout /T 3 /NOBREAK >nul
echo - Done.

echo.
echo [3/4] Updating repo (git pull) in: %~dp0
rem cd to this script directory and git pull
pushd "%~dp0" >nul
git pull
set "GIT_EXIT=%ERRORLEVEL%"
popd >nul

if not "%GIT_EXIT%"=="0" (
  echo - git pull failed with exit code %GIT_EXIT%.
  exit /b %GIT_EXIT%
)
echo - git pull succeeded.

echo.
echo [4/4] Starting: %EXE_NAME%
rem Run exe from this script directory
pushd "%~dp0" >nul
start "" "%~dp0%EXE_NAME%"
popd >nul
echo - Started (check task manager if needed).

endlocal
