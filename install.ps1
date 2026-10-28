# =========================================================
# NeoVibe — One-Click Automated Installer for Windows
# =========================================================

$ErrorActionPreference = "Stop"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "   NeoVibe Spotify Theme Installer     " -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# 1. Pastikan Spotify terpasang
$spotifyPath = "$env:APPDATA\Spotify\Spotify.exe"
if (!(Test-Path $spotifyPath)) {
    Write-Host "[PERINGATAN] Spotify versi desktop resmi belum terdeteksi di komputer Anda." -ForegroundColor Yellow
    Write-Host "Jika Anda menggunakan Spotify dari Microsoft Store, silakan unduh versi desktop dari:" -ForegroundColor Yellow
    Write-Host "https://www.spotify.com/download`n" -ForegroundColor Underline
}

# 2. Cek / Pasang Spicetify CLI
Write-Host "[1/4] Memeriksa Spicetify CLI..." -ForegroundColor Cyan
if (!(Get-Command spicetify -ErrorAction SilentlyContinue)) {
    Write-Host "Spicetify belum terpasang. Memasang Spicetify secara otomatis..." -ForegroundColor Yellow
    try {
        Invoke-Expression (Invoke-RestMethod -Uri "https://raw.githubusercontent.com/spicetify/cli/main/install.ps1")
        $env:PATH += ";$env:LOCALAPPDATA\spicetify"
    } catch {
        Write-Host "Gagal memasang Spicetify: $_" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Spicetify CLI sudah terpasang." -ForegroundColor Green
}

# 3. Menyiapkan Folder Tema
$themesDir = "$env:APPDATA\spicetify\Themes"
$targetDir = "$themesDir\NeoVibe"

if (!(Test-Path $themesDir)) {
    New-Item -ItemType Directory -Path $themesDir -Force | Out-Null
}

Write-Host "`n[2/4] Mengunduh berkas tema NeoVibe..." -ForegroundColor Cyan

$repoZipUrl = "https://github.com/ogiwarasuha/NeoVibe/archive/refs/heads/main.zip"
$tempZip = "$env:TEMP\NeoVibe.zip"
$tempExtract = "$env:TEMP\NeoVibe-extract"

try {
    if (Get-Command git -ErrorAction SilentlyContinue) {
        if (Test-Path $targetDir) { Remove-Item $targetDir -Recurse -Force }
        git clone https://github.com/ogiwarasuha/NeoVibe.git $targetDir
    } else {
        Invoke-WebRequest -Uri $repoZipUrl -OutFile $tempZip -UseBasicParsing
        if (Test-Path $tempExtract) { Remove-Item $tempExtract -Recurse -Force }
        Expand-Archive -Path $tempZip -DestinationPath $tempExtract -Force
        if (Test-Path $targetDir) { Remove-Item $targetDir -Recurse -Force }
        Move-Item "$tempExtract\NeoVibe-main" $targetDir -Force
        Remove-Item $tempZip, $tempExtract -Recurse -Force -ErrorAction SilentlyContinue
    }
    Write-Host "Berkas tema berhasil diunduh ke folder Themes." -ForegroundColor Green
} catch {
    Write-Host "Gagal mengunduh tema: $_" -ForegroundColor Red
    exit 1
}

# 4. Menerapkan Konfigurasi Spicetify
Write-Host "`n[3/4] Mengonfigurasi Spicetify..." -ForegroundColor Cyan
& spicetify config current_theme NeoVibe
& spicetify config inject_theme_js 1
& spicetify config inject_css 1
& spicetify config replace_colors 1

# 5. Terapkan Tema ke Spotify
Write-Host "`n[4/4] Memasang tema ke Spotify..." -ForegroundColor Cyan
& spicetify backup apply

Write-Host "`n========================================================" -ForegroundColor Green
Write-Host " Sukses! Tema NeoVibe berhasil dipasang ke Spotify.     " -ForegroundColor Green
Write-Host "========================================================`n" -ForegroundColor Green

