@echo off
setlocal
title NeoVibe Installer
echo ========================================================
echo         Memulai Instalasi Otomatis Tema NeoVibe         
echo ========================================================
echo.
echo Menjalankan skrip instalasi PowerShell...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-Expression (Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/ogiwarasuha/NeoVibe/main/install.ps1')"
echo.
pause

