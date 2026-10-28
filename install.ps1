# =========================================================
# NeoVibe — One-Click Automated Installer for Windows
# (Auto-Setup Spotify 1.2.77.358 + Anti-Update + Spicetify)
# =========================================================

$ErrorActionPreference = "Stop"

Write-Host "`n========================================================" -ForegroundColor Cyan
Write-Host "   NeoVibe Spotify Theme Installer (All-In-One Setup)   " -ForegroundColor Cyan
Write-Host "========================================================`n" -ForegroundColor Cyan

# 1. Pastikan Spotify v1.2.77.358 (Versi Paling Stabil untuk Mod/Tema)
Write-Host "[1/5] Memeriksa versi Spotify..." -ForegroundColor Cyan
$targetVersion = "1.2.77.358"
$spotifyPath = "$env:APPDATA\Spotify\Spotify.exe"
$currentVer = if (Test-Path $spotifyPath) { (Get-Item $spotifyPath).VersionInfo.ProductVersion } else { $null }

if ($currentVer -notlike "$targetVersion*") {
    Write-Host "Spotify versi $targetVersion belum terpasang (Versi saat ini: $(if ($currentVer) { $currentVer } else { 'Belum terpasang' }))." -ForegroundColor Yellow
    Write-Host "Mengunduh Spotify v$targetVersion (LTS Stabil & Bebas Bug)..." -ForegroundColor Cyan
    
    $downloadUrls = @(
        "https://github.com/ogiwarasuha/NeoVibe/releases/download/v1.0.0/Spotify_1.2.77.358.exe",
        "https://loadspot.amd64fox1.workers.dev/download/spotify_installer-1.2.77.358.g4339a634-x64.exe"
    )

    $tempInstaller = "$env:TEMP\Spotify_1.2.77.358.exe"
    Stop-Process -Name Spotify, SpotifyUpdate -Force -ErrorAction SilentlyContinue

    $downloadSuccess = $false
    foreach ($url in $downloadUrls) {
        try {
            Write-Host "Mengunduh dari $url..." -ForegroundColor Gray
            if (Get-Command curl.exe -ErrorAction SilentlyContinue) {
                & curl.exe -L $url -o $tempInstaller --progress-bar
            } else {
                (New-Object System.Net.WebClient).DownloadFile($url, $tempInstaller)
            }
            if ((Test-Path $tempInstaller) -and (Get-Item $tempInstaller).Length -gt 50MB) {
                $downloadSuccess = $true
                break
            }
        } catch {
            Write-Host "Gagal dari sumber ini, mencoba sumber cadangan..." -ForegroundColor Yellow
        }
    }

    if (!$downloadSuccess) {
        Write-Host "Gagal mengunduh installer Spotify 1.2.77.358. Silakan periksa koneksi internet Anda." -ForegroundColor Red
        exit 1
    }

    Write-Host "Mengekstrak dan memasang Spotify v$targetVersion..." -ForegroundColor Cyan
    $dest = "$env:APPDATA\Spotify"
    if (!(Test-Path $dest)) { New-Item -ItemType Directory -Path $dest -Force | Out-Null }
    Start-Process -FilePath $tempInstaller -ArgumentList "/extract `"$dest`"" -Wait

    # Buat shortcut desktop
    try {
        $wsh = New-Object -ComObject WScript.Shell
        $desktopShortcut = $wsh.CreateShortcut([Environment]::GetFolderPath("Desktop") + "\Spotify.lnk")
        $desktopShortcut.TargetPath = "$dest\Spotify.exe"
        $desktopShortcut.Save()
    } catch {}

    Write-Host "Spotify v$targetVersion berhasil dipasang." -ForegroundColor Green
} else {
    Write-Host "Spotify versi $targetVersion sudah terpasang." -ForegroundColor Green
}

# 2. Kunci dan Matikan Pembaruan Otomatis Spotify (Agar Tema Tidak Rusak)
Write-Host "`n[2/5] Mengunci pembaruan otomatis Spotify..." -ForegroundColor Cyan
try {
    Stop-Process -Name Spotify, SpotifyUpdate -Force -ErrorAction SilentlyContinue
    
    # Blokir folder Update di LocalAppData
    $localUpdate = "$env:LOCALAPPDATA\Spotify\Update"
    if (Test-Path $localUpdate) {
        icacls $localUpdate /reset /t /c /q 2>$null | Out-Null
        Remove-Item $localUpdate -Recurse -Force -ErrorAction SilentlyContinue
    }
    New-Item -ItemType File -Path $localUpdate -Force | Out-Null
    Set-ItemProperty -Path $localUpdate -Name Attributes -Value ([System.IO.FileAttributes]::ReadOnly)
    icacls $localUpdate /deny "*S-1-1-0:(W,D,X)" 2>$null | Out-Null

    # Blokir SpotifyUpdate.exe di AppData Roaming
    $roamingUpdate = "$env:APPDATA\Spotify\SpotifyUpdate.exe"
    if (Test-Path $roamingUpdate) {
        icacls $roamingUpdate /reset /q 2>$null | Out-Null
        Remove-Item $roamingUpdate -Force -ErrorAction SilentlyContinue
    }
    New-Item -ItemType File -Path $roamingUpdate -Force | Out-Null
    Set-ItemProperty -Path $roamingUpdate -Name Attributes -Value ([System.IO.FileAttributes]::ReadOnly)
    icacls $roamingUpdate /deny "*S-1-1-0:(W,D,X)" 2>$null | Out-Null

    Write-Host "Pembaruan otomatis Spotify berhasil dinonaktifkan." -ForegroundColor Green
} catch {
    Write-Host "Peringatan saat mengunci update: $_" -ForegroundColor Yellow
}

# 3. Cek / Pasang Spicetify CLI (Otomatis & Tanpa Prompt Marketplace)
Write-Host "`n[3/5] Memeriksa Spicetify CLI..." -ForegroundColor Cyan
$spicetifyDir = "$env:LOCALAPPDATA\spicetify"
$spicetifyExe = "$spicetifyDir\spicetify.exe"

if (!(Get-Command spicetify -ErrorAction SilentlyContinue) -and !(Test-Path $spicetifyExe)) {
    Write-Host "Spicetify belum terpasang. Memasang Spicetify CLI resmi..." -ForegroundColor Yellow
    try {
        $arch = if ([Environment]::Is64BitOperatingSystem) { "x64" } else { "x32" }
        if ($env:PROCESSOR_ARCHITECTURE -eq "ARM64") { $arch = "arm64" }
        $latest = Invoke-RestMethod -Uri "https://api.github.com/repos/spicetify/cli/releases/latest"
        $version = $latest.tag_name -replace '^v', ''
        $zipUrl = "https://github.com/spicetify/cli/releases/download/v$version/spicetify-$version-windows-$arch.zip"
        $tempSpiceZip = "$env:TEMP\spicetify.zip"

        Invoke-WebRequest -Uri $zipUrl -OutFile $tempSpiceZip -UseBasicParsing
        if (!(Test-Path $spicetifyDir)) { New-Item -ItemType Directory -Path $spicetifyDir -Force | Out-Null }
        Expand-Archive -Path $tempSpiceZip -DestinationPath $spicetifyDir -Force
        Remove-Item $tempSpiceZip -Force -ErrorAction SilentlyContinue

        # Daftarkan ke PATH pengguna
        $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
        if ($userPath -notlike "*$spicetifyDir*") {
            [Environment]::SetEnvironmentVariable("Path", "$userPath;$spicetifyDir", "User")
        }
        $env:PATH = "$env:PATH;$spicetifyDir"
        Write-Host "Spicetify CLI v$version berhasil dipasang." -ForegroundColor Green
    } catch {
        Write-Host "Gagal memasang Spicetify: $_" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Spicetify CLI sudah terpasang." -ForegroundColor Green
}

$spicetifyCmd = if (Get-Command spicetify -ErrorAction SilentlyContinue) { "spicetify" } else { $spicetifyExe }

# 4. Menyiapkan Folder Tema
$themesDir = "$env:APPDATA\spicetify\Themes"
$targetDir = "$themesDir\NeoVibe"

if (!(Test-Path $themesDir)) {
    New-Item -ItemType Directory -Path $themesDir -Force | Out-Null
}

Write-Host "`n[4/5] Mengunduh berkas tema NeoVibe..." -ForegroundColor Cyan

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

# 5. Menerapkan Konfigurasi Spicetify & Pasang ke Spotify
Write-Host "`n[5/5] Menerapkan tema NeoVibe ke Spotify..." -ForegroundColor Cyan
& $spicetifyCmd config current_theme NeoVibe
& $spicetifyCmd config inject_theme_js 1
& $spicetifyCmd config inject_css 1
& $spicetifyCmd config replace_colors 1

Stop-Process -Name Spotify, SpotifyUpdate -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1

# Bersihkan backup lama jika versi spotify berganti, lalu apply
& $spicetifyCmd clear
& $spicetifyCmd backup apply

Write-Host "`n========================================================" -ForegroundColor Green
Write-Host " Sukses! Spotify v$targetVersion + Tema NeoVibe Berhasil!" -ForegroundColor Green
Write-Host " Pembaruan otomatis Spotify telah dimatikan permanen.   " -ForegroundColor Green
Write-Host "========================================================`n" -ForegroundColor Green
