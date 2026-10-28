# NeoVibe — Spotify Neobrutalism Theme

> Tema Spotify modern berbasis Neobrutalism dengan Dynamic Album Art Colors dan All-In-One Built-In Extensions (Adblock, Hide Podcasts, No Controls).

---

## Daftar Isi
- [Fitur Utama](#fitur-utama)
- [Prasyarat](#prasyarat)
- [Instalasi Cepat (Pengguna Awam)](#instalasi-cepat-pengguna-awam)
- [Instalasi Manual (Langkah demi Langkah)](#instalasi-manual-langkah-demi-langkah)
  - [Langkah 1: Pasang Spicetify CLI](#langkah-1-pasang-spicetify-cli)
  - [Langkah 2: Unduh Tema NeoVibe](#langkah-2-unduh-tema-neovibe)
  - [Langkah 3: Terapkan Tema](#langkah-3-terapkan-tema)
- [Panduan Penggunaan](#panduan-penggunaan)
- [Penyelesaian Masalah (FAQ)](#penyelesaian-masalah-faq)

---

## Fitur Utama

- **Desain Neobrutalism Autentik**:
  - Sudut tajam presisi (*0px sharp corners*).
  - Garis batas hitam pekat (*crisp borders*) dengan bayangan padat (*hard offset shadow*).
  - Tipografi kontras tinggi yang bersih dan mudah dibaca.

- **Mode Warna Album Dinamis (Real-Time Dynamic Album Art Color)**:
  - Palet warna Spotify (latar belakang, kartu, playbar, tombol) secara otomatis diekstraksi dan menyesuaikan diri dengan cover album musik yang sedang diputar.
  - Dilengkapi transisi warna halus (*smooth transition*) pada setiap pergantian lagu (*song change*).

- **In-App Color Switcher**:
  - Menu *dropdown* pemilihan tema langsung di antarmuka atas Spotify (di sebelah tombol notifikasi).
  - Perpindahan skema warna instan tanpa perlu memuat ulang aplikasi atau menyunting berkas konfigurasi.
  - Pilihan skema bawaan:
    - `Warna Album (Dinamis)`
    - `Neo-Multicolor (Asli)`
    - `Neo-Yellow`
    - `Neo-Blue`
    - `Neo-Green`
    - `Neo-Orange`
    - `Neo-Red`
    - `Pink (Original)`

- **All-In-One Built-In Extensions (Terintegrasi Penuh)**:
  - **Adblock (oleh `rxri`)**: Memblokir iklan audio, video, serta banner promosi.
  - **Hide Podcasts (oleh `theRealPadster`)**: Menyembunyikan konten podcast dan buku audio agar antarmuka Spotify murni berfokus pada musik.
  - **No Controls (oleh `ohitstom`)**: Menyembunyikan tombol kontrol jendela bawaan (*minimize*, *maximize*, *close*) pada bilah judul (*titlebar*) untuk tampilan yang minimalis dan terpadu. Tekan tombol `F8` pada keyboard untuk memunculkan atau menyembunyikan tombol kontrol sewaktu-waktu.

---

## Prasyarat

Pastikan aplikasi Spotify yang terpasang di komputer Anda adalah **Spotify Desktop resmi**, bukan versi dari Microsoft Store.

- **Pemeriksaan Versi:** Buka Spotify -> klik menu titik tiga di pojok kiri atas -> **Help** -> **About Spotify**.
- **Pengguna Microsoft Store:** Versi dari Microsoft Store dibatasi oleh sistem izin sandboxing Windows sehingga Spicetify tidak dapat memodifikasi berkasnya. Jika terpasang versi Microsoft Store:
  1. Hapus instalasi (*uninstall*) Spotify versi Microsoft Store.
  2. Unduh dan pasang versi resmi desktop melalui situs resmi: [spotify.com/download](https://www.spotify.com/download).

---

## Instalasi Cepat (Pengguna Awam)

Bagi Anda yang menginginkan proses instalasi otomatis tanpa perlu menyalin berkas secara manual, gunakan salah satu pilihan berikut:

### Pilihan 1: Jalankan Satu Perintah di PowerShell
1. Buka **PowerShell** (tekan tombol `Windows`, ketik `PowerShell`, lalu tekan `Enter`).
2. Salin dan tempel perintah satu baris berikut, kemudian tekan `Enter`:

```powershell
iwr -useb https://raw.githubusercontent.com/ogiwarasuha/NeoVibe/main/install.ps1 | iex
```

Skrip ini akan secara otomatis mendeteksi dan memasang Spicetify jika belum ada, mengunduh tema NeoVibe, dan langsung menerapkannya ke Spotify Anda.

### Pilihan 2: Unduh Berkas Installer Otomatis
1. [Unduh Berkas install.bat](https://raw.githubusercontent.com/ogiwarasuha/NeoVibe/main/install.bat)
2. Klik dua kali berkas `install.bat` yang baru saja diunduh.
3. Jendela instalasi akan berjalan secara otomatis hingga tema NeoVibe aktif di Spotify.

---

## Instalasi Manual (Langkah demi Langkah)

Bagi pengguna yang ingin memasang dan mengonfigurasi tema secara mandiri:

### Langkah 1: Pasang Spicetify CLI

Jika Anda belum pernah memasang Spicetify, buka terminal:

**Windows (PowerShell):**
```powershell
iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex
```

**macOS / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
```

---

### Langkah 2: Unduh Tema NeoVibe

Pilih salah satu metode berikut:

#### Metode A: Menggunakan Git Clone (Direkomendasikan)
Buka terminal dan jalankan perintah satu baris berikut untuk meng-clone repositori langsung ke direktori tema Spicetify:

**Windows (PowerShell):**
```powershell
git clone https://github.com/ogiwarasuha/NeoVibe.git "$env:APPDATA\spicetify\Themes\NeoVibe"
```

**macOS / Linux:**
```bash
git clone https://github.com/ogiwarasuha/NeoVibe.git ~/.config/spicetify/Themes/NeoVibe
```

#### Metode B: Unduh Berkas ZIP Tema
1. [Klik di sini untuk mengunduh berkas tema (ZIP)](https://github.com/ogiwarasuha/NeoVibe/archive/refs/heads/main.zip) atau klik tombol **Code** -> **Download ZIP** pada halaman repositori.
2. Ekstrak berkas ZIP yang telah diunduh.
3. Ubah nama folder hasil ekstraksi menjadi **`NeoVibe`** (jika sebelumnya bernama `NeoVibe-main`).
4. Buka direktori tema Spicetify:
   - Tekan pintasan `Windows + R`.
   - Ketik `%appdata%\spicetify\Themes` lalu tekan `Enter`.
5. Pindahkan folder **`NeoVibe`** ke dalam direktori tersebut.

Pastikan struktur direktori tersusun sebagai berikut:
```text
spicetify/
└── Themes/
    └── NeoVibe/
        ├── color.ini
        ├── user.css
        ├── theme.js
        ├── install.bat
        ├── install.ps1
        └── README.md
```

---

### Langkah 3: Terapkan Tema

Buka kembali jendela **PowerShell** dan jalankan perintah berikut secara berurutan:

```powershell
spicetify config current_theme NeoVibe
spicetify config inject_theme_js 1
spicetify config inject_css 1
spicetify config replace_colors 1
spicetify backup apply
```

Spotify akan otomatis memuat ulang dan membuka antarmuka dengan tema NeoVibe.

---

## Panduan Penggunaan

### 1. Mengganti Skema Warna
1. Arahkan kursor ke bilah atas jendela Spotify, tepat di sebelah kiri tombol notifikasi.
2. Klik tombol nama skema warna yang sedang aktif.
3. Pilih salah satu skema dari menu *dropdown*.
4. Jika memilih **Warna Album (Dinamis)**, putar lagu apa saja untuk melihat warna tema bertransformasi mengikuti artwork album lagu yang sedang berjalan.

### 2. Mengontrol Tombol Jendela (Minimize / Maximize / Close)
- Tema menyembunyikan tombol kontrol jendela bawaan sistem untuk mempertahankan keselarasan estetika.
- Untuk menampilkan kembali tombol kontrol jendela, tekan tombol **`F8`** pada keyboard.
- Tekan **`F8`** sekali lagi untuk menyembunyikannya kembali.
- Alternatif pintasan keyboard standar Windows:
  - `Alt + F4` : Menutup aplikasi.
  - `Windows + Panah Bawah` : Me-minimize jendela.

---

## Penyelesaian Masalah (FAQ)

#### Spotify baru saja diperbarui otomatis dan tampilan tema hilang?
Setiap pembaruan aplikasi Spotify akan me-reset berkas internal client. Jalankan kembali perintah berikut di PowerShell:
```powershell
spicetify backup apply
```
Tema NeoVibe beserta seluruh fitur ekstensinya akan langsung aktif kembali.

#### Muncul galat `Spotify path is not valid` saat menjalankan perintah?
Hal ini umumnya terjadi jika Spotify terpasang dari Microsoft Store. Hapus versi tersebut dan pasang versi desktop installer dari [spotify.com/download](https://www.spotify.com/download).

#### Bagaimana cara mengembalikan Spotify ke tampilan bawaan (uninstall tema)?
Untuk mengembalikan Spotify ke kondisi default, jalankan perintah:
```powershell
spicetify restore
```

---

<p align="center">
  NeoVibe Theme &mdash; Dibuat untuk komunitas Spicetify dan penikmat estetika Neobrutalism.
</p>
