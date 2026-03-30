@echo off
setlocal

set "EXE_NAME=zWebView2Agent.exe"

rem Kill process (ignore if not running)
taskkill /F /IM "%EXE_NAME%" >nul 2>&1

rem Wait 3 seconds
timeout /T 3 /NOBREAK >nul

rem cd to this script directory and git pull
pushd "%~dp0" >nul
git pull
set "GIT_EXIT=%ERRORLEVEL%"
popd >nul

if not "%GIT_EXIT%"=="0" (
  echo git pull failed with exit code %GIT_EXIT%.
  exit /b %GIT_EXIT%
)

rem Run exe from this script directory
pushd "%~dp0" >nul
start "" "%~dp0%EXE_NAME%"
popd >nul

endlocal
