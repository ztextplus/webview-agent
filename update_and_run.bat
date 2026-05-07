@echo off
setlocal


cd /d "%~dp0"

echo.
echo [1/4] Killing process: %EXE_NAME%
rem Kill process (ignore if not running)
taskkill /F /IM zWebView2Agent.exe >nul 2>&1


echo.
echo [2/4] Waiting 3 seconds...
rem Wait 3 seconds
timeout /T 3 /NOBREAK >nul
echo - Done.

echo.
echo [3/4] Updating repo (git pull) in: "%~dp0"
git pull
set "GIT_EXIT=%ERRORLEVEL%"

if not "%GIT_EXIT%"=="0" (
  echo - ERROR: git pull failed with exit code %GIT_EXIT%.
  echo - Please check your network connection or repository status.
  echo.
  pause
  exit /b %GIT_EXIT%
)
echo - git pull succeeded.

echo.
echo [4/4] Starting: %EXE_NAME%
start "" "%~dp0%EXE_NAME%"
echo - Started (check task manager if needed).

echo.
echo Done. Press any key to exit...
pause
endlocal
