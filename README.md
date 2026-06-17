# Docker WordPress Production Lab

[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://nginx.org/)
[![PHP--FPM](https://img.shields.io/badge/PHP--FPM-777BB4?style=for-the-badge&logo=php&logoColor=white)](https://www.php.net/)
[![WordPress](https://img.shields.io/badge/WordPress-21759B?style=for-the-badge&logo=wordpress&logoColor=white)](https://wordpress.org/)

Proyek ini adalah lab implementasi infrastruktur **WordPress siap produksi (Production-Ready)** menggunakan Docker. Berbeda dengan setup standar yang menggabungkan web server dan PHP dalam satu kontainer, proyek ini memisahkan **Nginx** dan **PHP-FPM** ke dalam layanan terpisah untuk mensimulasikan arsitektur *high-performance*, *scalable*, dan aman.

---

## 🚀 Fitur Utama

* **Arsitektur Terpisah:** Nginx bertindak murni sebagai *reverse proxy* dan *static file server*, meneruskan request dinamis ke PHP-FPM melalui protokol FastCGI.
* **Production-Ready Config:** Konfigurasi Nginx disesuaikan untuk keamanan (menyembunyikan versi, proteksi akses file sensitif) dan performa.
* **Automated Backup System:** Menyediakan shell script untuk mencadangkan database dan seluruh berkas penting secara otomatis.
* **Environment Isolated:** Konfigurasi sensitif dipisahkan menggunakan environment variables (`.env`).

---

## 📁 Struktur Direktori

```text
docker-wordpress-production-lab/
├── nginx/               # Konfigurasi server block Nginx & FastCGI
├── php-fpm/             # Custom Dockerfile & optimalisasi PHP (Opcache, dll)
├── scripts/             # Shell script manajemen infrastruktur
│   └── backup-all.sh    # Script otomatisasi backup sistem dan database
├── .gitignore           # Mengabaikan file sensitif dan log lokal
├── docker-compose.yml   # Orchestration seluruh layanan (Nginx, PHP-FPM, DB)
└── README.md            # Dokumentasi proyek
```

---

## 🛠️ Prasyarat (Prerequisites)

Sebelum menjalankan proyek ini di lingkungan server atau lokal Anda, pastikan sistem telah memenuhi persyaratan berikut:

1. **Sistem Operasi:** Berbasis Linux (Ubuntu/Debian disarankan) atau WSL2 jika menggunakan Windows.
2. **Docker Engine:** Versi `20.10+` atau yang terbaru.
3. **Docker Compose:** Versi `2.0+` (perintah menggunakan `docker compose`, bukan `docker-compose`).
4. **Hak Akses Eksekusi:** Hak akses `sudo` atau user yang tergabung dalam grup `docker` untuk menjalankan kontainer dan *script*.

---

## 🏁 Tutorial Penggunaan

Ikuti langkah-langkah di bawah ini untuk melakukan deploy lab ini di mesin Anda:

### 1. Clone Repositori
```bash
git clone [https://github.com/Suminona06/docker-wordpress-production-lab.git](https://github.com/Suminona06/docker-wordpress-production-lab.git)
cd docker-wordpress-production-lab
```

### 2. Konfigurasi Environment Variable
Buat sebuah file bernama `.env` di root direktori proyek ini, lalu sesuaikan kredensial database Anda seperti contoh berikut:
```env
MYSQL_ROOT_PASSWORD=password_root_rahasia
MYSQL_DATABASE=wordpress_db
MYSQL_USER=wp_user
MYSQL_PASSWORD=password_wp_rahasia
```

### 3. Build dan Jalankan Infrastruktur
Eksekusi perintah berikut untuk membangun *custom image* dan menjalankan seluruh layanan di *background* (*detached mode*):
```bash
docker compose up -d --build
```

### 4. Selesaikan Instalasi WordPress
Buka peramban (browser) Anda dan akses:
* `http://localhost` (jika di lokal) atau `http://IP_Server_Anda` untuk masuk ke halaman setup awal WordPress.

---

## 💾 Sistem Otomatisasi Backup (`backup-all.sh`)

Proyek ini dilengkapi dengan shell script `scripts/backup-all.sh` untuk menjaga keamanan data produksi Anda. 

### Apa saja yang dilakukan script ini?
1. **Load Environment:** Otomatis membaca kredensial database langsung dari file `.env`.
2. **Database Dump:** Melakukan dump database MariaDB dari dalam kontainer `wp_database` secara aman tanpa mematikan layanan.
3. **Files Backup:** Mengompres folder data `wordpress` (`wp-content`, dll) menjadi file `.tar.gz`.
4. **Configuration Backup:** Mencadangkan file konfigurasi penting seperti `docker-compose.yml`, folder `nginx`, `php-fpm`, dan `scripts`.
5. **Retention Policy:** Secara otomatis menghapus file backup lama yang usianya sudah **lebih dari 7 hari** untuk menghemat ruang penyimpanan disk.
6. **Logging:** Mencatat status dan riwayat keberhasilan setiap proses backup ke dalam file `logs/backup/backup.log`.

### Cara Menjalankan Backup

1. Pastikan script memiliki izin eksekusi (*executable permission*):
   ```bash
   chmod +x scripts/backup-all.sh
   ```
2. Jalankan script secara manual:
   ```bash
   ./scripts/backup-all.sh
   ```

> 💡 **Tips Produksi:** Anda bisa menjadwalkan script ini agar berjalan otomatis setiap hari pada jam 2 dini hari menggunakan **Cron Job** dengan perintah `crontab -e`:
> ```text
> 0 2 * * * /bin/bash /var/www/wordpress/scripts/backup-all.sh
> ```

---

## 🤝 Kontribusi

Kontribusi sangat terbuka lebar! Jika Anda menemukan *bug* atau ingin menambahkan fitur baru (seperti integrasi Redis Cache atau SSL Let's Encrypt), silakan ajukan **Pull Request** atau buka **Issue**.

---

🧑‍💻 **Dibuat oleh [Azis Muhamad Fadli](https://github.com/Suminona06)**
