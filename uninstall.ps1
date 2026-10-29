# =========================================================
# NeoVibe — Clean Uninstaller for Windows
# (Mengembalikan Spotify ke Kondisi Bersih / Stock)
# =========================================================

param (
    [switch]$FullClean
)

$ErrorActionPreference = "SilentlyContinue"

Write-Host "`n========================================================" -ForegroundColor Yellow
Write-Host "       NeoVibe Clean Uninstaller (Spotify Reset)        " -ForegroundColor Yellow
Write-Host "========================================================`n" -ForegroundColor Yellow

# 1. Tutup Semua Proses
Write-Host "[1/5] Menutup proses Spotify dan Spicetify..." -ForegroundColor Cyan
Stop-Process -Name Spotify, SpotifyUpdate, SpotifyInstaller, spicetify -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1

# 2. Kembalikan Spotify ke Original State via Spicetify
Write-Host "[2/5] Mengembalikan berkas Spotify ke kondisi awal (stock)..." -ForegroundColor Cyan
$spicetifyExe = "$env:LOCALAPPDATA\spicetify\spicetify.exe"
if (Get-Command spicetify -ErrorAction SilentlyContinue) {
    spicetify restore
} elseif (Test-Path $spicetifyExe) {
    & $spicetifyExe restore
}

# 3. Buka Kunci Auto-Update Spotify
Write-Host "[3/5] Membuka kembali kunci pembaruan otomatis Spotify..." -ForegroundColor Cyan
$localUpdate = "$env:LOCALAPPDATA\Spotify\Update"
$roamingUpdate = "$env:APPDATA\Spotify\SpotifyUpdate.exe"

if (Test-Path $localUpdate) {
    icacls $localUpdate /reset /t /c /q 2>$null | Out-Null
    Remove-Item $localUpdate -Recurse -Force -ErrorAction SilentlyContinue
}

if (Test-Path $roamingUpdate) {
    icacls $roamingUpdate /reset /q 2>$null | Out-Null
    Remove-Item $roamingUpdate -Force -ErrorAction SilentlyContinue
}

# 4. Hapus Berkas Tema NeoVibe
Write-Host "[4/5] Menghapus folder tema NeoVibe..." -ForegroundColor Cyan
$themePath = "$env:APPDATA\spicetify\Themes\NeoVibe"
if (Test-Path $themePath) {
    Remove-Item $themePath -Recurse -Force -ErrorAction SilentlyContinue
}

# 5. Bersihkan Cache Sisa Modifikasi
Write-Host "[5/5] Membersihkan cache sisa modifikasi..." -ForegroundColor Cyan
$browserCache = "$env:LOCALAPPDATA\Spotify\Browser"
if (Test-Path $browserCache) {
    Remove-Item $browserCache -Recurse -Force -ErrorAction SilentlyContinue
}

# Opsional: Pembersihan Total (Jika parameter -FullClean disertakan)
if ($FullClean) {
    Write-Host "`nMenjalankan Pembersihan Total (Full Clean)..." -ForegroundColor Yellow
    Get-AppxPackage -AllUsers *Spotify* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
    Get-AppxPackage *Spotify* | Remove-AppxPackage -ErrorAction SilentlyContinue

    if (Get-Command winget.exe -ErrorAction SilentlyContinue) {
        try {
            & winget.exe uninstall --id Spotify.Spotify -e --silent --accept-source-agreements 2>&1 | Out-Null
            & winget.exe uninstall --id 9NCBCSZSJRSB -e --silent --accept-source-agreements 2>&1 | Out-Null
        } catch {}
    }

    if (Test-Path "$env:LOCALAPPDATA\Spotify") {
        icacls "$env:LOCALAPPDATA\Spotify" /reset /t /c /q 2>$null | Out-Null
        Remove-Item "$env:LOCALAPPDATA\Spotify" -Recurse -Force -ErrorAction SilentlyContinue
    }
    if (Test-Path "$env:APPDATA\Spotify") {
        icacls "$env:APPDATA\Spotify" /reset /t /c /q 2>$null | Out-Null
        Remove-Item "$env:APPDATA\Spotify" -Recurse -Force -ErrorAction SilentlyContinue
    }
    if (Test-Path "$env:LOCALAPPDATA\spicetify") {
        Remove-Item "$env:LOCALAPPDATA\spicetify" -Recurse -Force -ErrorAction SilentlyContinue
    }
    if (Test-Path "$env:APPDATA\spicetify") {
        Remove-Item "$env:APPDATA\spicetify" -Recurse -Force -ErrorAction SilentlyContinue
    }
    Write-Host "Semua Spotify dan Spicetify berhasil dihapus bersih tanpa sisa." -ForegroundColor Green
}

Write-Host "`n========================================================" -ForegroundColor Green
Write-Host " Sukses! Spotify telah bersih kembali ke kondisi original." -ForegroundColor Green
Write-Host "========================================================`n" -ForegroundColor Green
