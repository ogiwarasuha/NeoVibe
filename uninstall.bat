@echo off
setlocal
title NeoVibe Clean Uninstaller
echo ========================================================
echo       Memulai Pembersihan Tema NeoVibe & Spicetify       
echo ========================================================
echo.
if exist "%~dp0uninstall.ps1" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0uninstall.ps1"
) else (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-Expression (Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/ogiwarasuha/NeoVibe/main/uninstall.ps1')"
)
echo.
pause
