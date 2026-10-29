# =========================================================
# NeoVibe — One-Click Automated Clean Installer for Windows
# (Pembersihan Total + Spotify 1.2.77.358 LTS + Anti-Update + Spicetify + Tema)
# =========================================================

$ErrorActionPreference = "Stop"

Write-Host "`n========================================================" -ForegroundColor Cyan
Write-Host "   NeoVibe Spotify Theme Installer (All-In-One Clean)   " -ForegroundColor Cyan
Write-Host "========================================================`n" -ForegroundColor Cyan

# 1. Hentikan Semua Proses Terkait Spotify & Spicetify
Write-Host "[1/6] Menutup semua proses Spotify dan Spicetify..." -ForegroundColor Cyan
Stop-Process -Name Spotify, SpotifyUpdate, SpotifyInstaller, spicetify -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1

# 2. Hapus Bersih Spotify Microsoft Store / UWP & Sisa Instalasi Lama
Write-Host "`n[2/6] Membersihkan semua Spotify lama (termasuk versi Microsoft Store)..." -ForegroundColor Cyan

# Hapus Spotify dari Microsoft Store (UWP) via PowerShell & Winget
try {
    Get-AppxPackage -AllUsers *Spotify* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
    Get-AppxPackage *Spotify* | Remove-AppxPackage -ErrorAction SilentlyContinue
} catch {}

if (Get-Command winget.exe -ErrorAction SilentlyContinue) {
    try {
        & winget.exe uninstall --id Spotify.Spotify -e --silent --accept-source-agreements 2>&1 | Out-Null
        & winget.exe uninstall --id 9NCBCSZSJRSB -e --silent --accept-source-agreements 2>&1 | Out-Null
    } catch {}
}

# Reset izin keamanan folder Spotify lama sebelum dihapus (agar tidak Access Denied)
$spotifyLocal = "$env:LOCALAPPDATA\Spotify"
$spotifyRoaming = "$env:APPDATA\Spotify"

if (Test-Path $spotifyLocal) {
    try {
        icacls $spotifyLocal /reset /t /c /q 2>$null | Out-Null
        Get-ChildItem -Path $spotifyLocal -Recurse -Force -ErrorAction SilentlyContinue | ForEach-Object { $_.Attributes = 'Normal' }
        Remove-Item $spotifyLocal -Recurse -Force -ErrorAction SilentlyContinue
    } catch {}
}

if (Test-Path $spotifyRoaming) {
    try {
        icacls $spotifyRoaming /reset /t /c /q 2>$null | Out-Null
        Get-ChildItem -Path $spotifyRoaming -Recurse -Force -ErrorAction SilentlyContinue | ForEach-Object { $_.Attributes = 'Normal' }
        Remove-Item $spotifyRoaming -Recurse -Force -ErrorAction SilentlyContinue
    } catch {}
}

# Hapus bersih seluruh folder Spicetify lama (Clean Slate)
Write-Host "Membersihkan direktori Spicetify lama..." -ForegroundColor Cyan
$spicetifyLocal = "$env:LOCALAPPDATA\spicetify"
$spicetifyRoaming = "$env:APPDATA\spicetify"

if (Test-Path $spicetifyLocal) {
    Remove-Item $spicetifyLocal -Recurse -Force -ErrorAction SilentlyContinue
}
if (Test-Path $spicetifyRoaming) {
    Remove-Item $spicetifyRoaming -Recurse -Force -ErrorAction SilentlyContinue
}

# Hapus shortcut Spotify lama jika ada
$desktopShortcutPath = [Environment]::GetFolderPath("Desktop") + "\Spotify.lnk"
if (Test-Path $desktopShortcutPath) {
    Remove-Item $desktopShortcutPath -Force -ErrorAction SilentlyContinue
}

Write-Host "Sistem telah bersih total dari Spotify & Spicetify lama." -ForegroundColor Green

# 3. Unduh & Pasang Spotify v1.2.77.358 LTS Stabil
Write-Host "`n[3/6] Menyiapkan Spotify v1.2.77.358 LTS..." -ForegroundColor Cyan
$targetVersion = "1.2.77.358"
$tempInstaller = "$env:TEMP\Spotify_1.2.77.358.exe"

# Periksa apakah installer sudah pernah diunduh dan valid (> 50MB)
$needDownload = $true
if (Test-Path $tempInstaller) {
    if ((Get-Item $tempInstaller).Length -gt 50MB) {
        $needDownload = $false
        Write-Host "Installer Spotify 1.2.77.358 ditemukan di cache lokal." -ForegroundColor Green
    }
}

if ($needDownload) {
    Write-Host "Mengunduh Spotify v$targetVersion (LTS Bebas Bug)..." -ForegroundColor Cyan
    $downloadUrls = @(
        "https://github.com/ogiwarasuha/NeoVibe/releases/download/v1.0.0/Spotify_1.2.77.358.exe",
        "https://loadspot.amd64fox1.workers.dev/download/spotify_installer-1.2.77.358.g4339a634-x64.exe"
    )

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
}

Write-Host "Memasang Spotify v$targetVersion..." -ForegroundColor Cyan
$dest = "$env:APPDATA\Spotify"
if (!(Test-Path $dest)) { New-Item -ItemType Directory -Path $dest -Force | Out-Null }
Start-Process -FilePath $tempInstaller -ArgumentList "/extract `"$dest`"" -Wait

if (!(Test-Path "$dest\Spotify.exe")) {
    Write-Host "Mengekstrak via mode silent..." -ForegroundColor Yellow
    Start-Process -FilePath $tempInstaller -ArgumentList "/silent" -Wait
}

# Buat shortcut desktop baru
try {
    $wsh = New-Object -ComObject WScript.Shell
    $shortcut = $wsh.CreateShortcut($desktopShortcutPath)
    $shortcut.TargetPath = "$dest\Spotify.exe"
    $shortcut.Save()
} catch {}

# Inisialisasi berkas prefs awal agar Spicetify langsung mendeteksinya
$prefsFile = "$dest\prefs"
if (!(Test-Path $prefsFile)) {
    Set-Content -Path $prefsFile -Value "app.last-launched-version=`"$targetVersion`"" -Force
}

Write-Host "Spotify v$targetVersion berhasil dipasang." -ForegroundColor Green

# 4. Kunci Pembaruan Otomatis Spotify (Permanen)
Write-Host "`n[4/6] Mengunci pembaruan otomatis Spotify..." -ForegroundColor Cyan
try {
    Stop-Process -Name Spotify, SpotifyUpdate -Force -ErrorAction SilentlyContinue

    # Blokir folder Update di LocalAppData
    $localUpdate = "$env:LOCALAPPDATA\Spotify\Update"
    $localParent = "$env:LOCALAPPDATA\Spotify"
    if (!(Test-Path $localParent)) { New-Item -ItemType Directory -Path $localParent -Force | Out-Null }
    if (Test-Path $localUpdate) {
        icacls $localUpdate /reset /t /c /q 2>$null | Out-Null
        Remove-Item $localUpdate -Recurse -Force -ErrorAction SilentlyContinue
    }
    New-Item -ItemType File -Path $localUpdate -Force | Out-Null
    Set-ItemProperty -Path $localUpdate -Name Attributes -Value ([System.IO.FileAttributes]::ReadOnly)
    icacls $localUpdate /deny "*S-1-1-0:(W,D)" 2>$null | Out-Null

    # Blokir SpotifyUpdate.exe di AppData Roaming
    $roamingUpdate = "$env:APPDATA\Spotify\SpotifyUpdate.exe"
    if (Test-Path $roamingUpdate) {
        icacls $roamingUpdate /reset /q 2>$null | Out-Null
        Remove-Item $roamingUpdate -Force -ErrorAction SilentlyContinue
    }
    New-Item -ItemType File -Path $roamingUpdate -Force | Out-Null
    Set-ItemProperty -Path $roamingUpdate -Name Attributes -Value ([System.IO.FileAttributes]::ReadOnly)
    icacls $roamingUpdate /deny "*S-1-1-0:(W,D)" 2>$null | Out-Null

    Write-Host "Pembaruan otomatis Spotify berhasil dinonaktifkan." -ForegroundColor Green
} catch {
    Write-Host "Peringatan saat mengunci update: $_" -ForegroundColor Yellow
}

# 5. Pasang Spicetify CLI Resmi Terbaru (Fresh)
Write-Host "`n[5/6] Memasang Spicetify CLI..." -ForegroundColor Cyan
$spicetifyDir = "$env:LOCALAPPDATA\spicetify"
$spicetifyExe = "$spicetifyDir\spicetify.exe"

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

$spicetifyCmd = if (Test-Path $spicetifyExe) { $spicetifyExe } else { "spicetify" }

# Unduh Berkas Tema NeoVibe
$themesDir = "$env:APPDATA\spicetify\Themes"
$targetThemeDir = "$themesDir\NeoVibe"
if (!(Test-Path $themesDir)) { New-Item -ItemType Directory -Path $themesDir -Force | Out-Null }

Write-Host "Mengunduh berkas tema NeoVibe terbaru..." -ForegroundColor Cyan
$repoZipUrl = "https://github.com/ogiwarasuha/NeoVibe/archive/refs/heads/main.zip"
$tempZip = "$env:TEMP\NeoVibe.zip"
$tempExtract = "$env:TEMP\NeoVibe-extract"

try {
    if (Get-Command git -ErrorAction SilentlyContinue) {
        if (Test-Path $targetThemeDir) { Remove-Item $targetThemeDir -Recurse -Force }
        git clone https://github.com/ogiwarasuha/NeoVibe.git $targetThemeDir
    } else {
        Invoke-WebRequest -Uri $repoZipUrl -OutFile $tempZip -UseBasicParsing
        if (Test-Path $tempExtract) { Remove-Item $tempExtract -Recurse -Force }
        Expand-Archive -Path $tempZip -DestinationPath $tempExtract -Force
        if (Test-Path $targetThemeDir) { Remove-Item $targetThemeDir -Recurse -Force }
        Move-Item "$tempExtract\NeoVibe-main" $targetThemeDir -Force
        Remove-Item $tempZip, $tempExtract -Recurse -Force -ErrorAction SilentlyContinue
    }
    Write-Host "Berkas tema berhasil diunduh ke folder Themes." -ForegroundColor Green
} catch {
    Write-Host "Gagal mengunduh tema: $_" -ForegroundColor Red
    exit 1
}

# 6. Menerapkan Tema ke Spotify
Write-Host "`n[6/6] Menerapkan tema NeoVibe ke Spotify..." -ForegroundColor Cyan

& $spicetifyCmd config spotify_path $dest
& $spicetifyCmd config prefs_path $prefsFile
& $spicetifyCmd config current_theme NeoVibe
& $spicetifyCmd config inject_theme_js 1
& $spicetifyCmd config inject_css 1
& $spicetifyCmd config replace_colors 1

Stop-Process -Name Spotify, SpotifyUpdate -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1

# Terapkan konfigurasi tema (backup apply untuk instalasi bersih)
$oldPref = $ErrorActionPreference
$ErrorActionPreference = "Continue"

& $spicetifyCmd backup apply
if ($LASTEXITCODE -ne 0) {
    & $spicetifyCmd apply
}

$ErrorActionPreference = $oldPref

Write-Host "`n========================================================" -ForegroundColor Green
Write-Host " Sukses! Spotify v$targetVersion + Tema NeoVibe Berhasil!" -ForegroundColor Green
Write-Host " Bersih total dari sisa instalasi lama & anti-update aktif." -ForegroundColor Green
Write-Host "========================================================`n" -ForegroundColor Green
