# =========================================================
# NeoVibe — Clean Uninstaller for Windows
# (Mengembalikan Spotify ke Asli + Hapus Tema & Spicetify)
# =========================================================

$ErrorActionPreference = "SilentlyContinue"

Write-Host "`n========================================================" -ForegroundColor Yellow
Write-Host "       NeoVibe Clean Uninstaller (Spotify Reset)        " -ForegroundColor Yellow
Write-Host "========================================================`n" -ForegroundColor Yellow

# 1. Tutup Semua Proses Terkait
Write-Host "[1/5] Menutup proses Spotify dan Spicetify..." -ForegroundColor Cyan
Stop-Process -Name Spotify, SpotifyUpdate, SpotifyInstaller, spicetify -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1

# 2. Kembalikan Spotify ke Kondisi Awal (Stock)
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

# 4. Hapus Tema NeoVibe & Hapus Bersih Spicetify CLI
Write-Host "[4/5] Menghapus tema NeoVibe dan Spicetify sepenuhnya..." -ForegroundColor Cyan
$spicetifyLocal = "$env:LOCALAPPDATA\spicetify"
$spicetifyRoaming = "$env:APPDATA\spicetify"

if (Test-Path $spicetifyRoaming) {
    Remove-Item $spicetifyRoaming -Recurse -Force -ErrorAction SilentlyContinue
}
if (Test-Path $spicetifyLocal) {
    Remove-Item $spicetifyLocal -Recurse -Force -ErrorAction SilentlyContinue
}

# Bersihkan Spicetify dari Environment PATH Pengguna
try {
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($userPath -like "*spicetify*") {
        $cleanPath = ($userPath -split ';' | Where-Object { $_ -notlike "*spicetify*" -and $_.Trim() -ne "" }) -join ';'
        [Environment]::SetEnvironmentVariable("Path", $cleanPath, "User")
    }
} catch {}

# 5. Bersihkan Cache Sisa Modifikasi
Write-Host "[5/5] Membersihkan cache sisa modifikasi..." -ForegroundColor Cyan
$browserCache = "$env:LOCALAPPDATA\Spotify\Browser"
if (Test-Path $browserCache) {
    Remove-Item $browserCache -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host "`n========================================================" -ForegroundColor Green
Write-Host " Sukses! Tema NeoVibe & Spicetify telah dihapus bersih. " -ForegroundColor Green
Write-Host " Spotify Anda telah kembali normal ke kondisi original. " -ForegroundColor Green
Write-Host "========================================================`n" -ForegroundColor Green
