@echo off
REM Launch TradingView Desktop on Windows with Chrome DevTools Protocol enabled
REM Supports classic installs and the Microsoft Store (MSIX) package.
REM Usage: scripts\launch_tv_debug.bat [port]

set "PORT=%~1"
if "%PORT%"=="" set "PORT=9222"

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0launch_tv_debug.ps1" -Port %PORT%
exit /b %errorlevel%
