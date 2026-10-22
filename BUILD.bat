@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"
echo ===============================================
echo KineMaster Studio v8.1.15 AI - Win32 Installer
echo ===============================================
echo.
where node >nul 2>nul
if errorlevel 1 (
  echo ERROR: Node.js is not installed.
  echo For Windows 7, use the final compatible Node.js 16.x release, such as 16.20.2.
  echo Install the Windows x86 version if your operating system is 32-bit.
  pause
  exit /b 1
)
where npm >nul 2>nul
if errorlevel 1 (
  echo ERROR: npm was not found. Reinstall Node.js and include npm.
  pause
  exit /b 1
)
echo Node version:
node --version
echo.
echo Installing the exact Electron and builder dependencies...
call npm install
if errorlevel 1 (
  echo.
  echo ERROR: Dependency installation failed. Check internet access and Node.js version.
  pause
  exit /b 1
)
echo.
echo Building 32-bit Windows NSIS installer...
call npm run dist:win32
if errorlevel 1 (
  echo.
  echo ERROR: Installer build failed. Review the messages above.
  pause
  exit /b 1
)
echo.
echo BUILD COMPLETE. Look inside the dist folder for the Setup EXE.
explorer "%~dp0dist"
pause
