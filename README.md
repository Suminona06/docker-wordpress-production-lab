# Docker WordPress Production Lab

[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://nginx.org/)
[![PHP--FPM](https://img.shields.io/badge/PHP--FPM-777BB4?style=for-the-badge&logo=php&logoColor=white)](https://www.php.net/)
[![WordPress](https://img.shields.io/badge/WordPress-21759B?style=for-the-badge&logo=wordpress&logoColor=white)](https://wordpress.org/)

Proyek ini adalah lab implementasi infrastruktur **WordPress siap produksi (Production-Ready)** menggunakan Docker. Berbeda dengan setup standar yang menggabungkan web server dan PHP dalam satu *container*, proyek ini memisahkan **Nginx** dan **PHP-FPM** ke dalam layanan terpisah untuk mensimulasikan arsitektur *high-performance*, *scalable*, dan aman.

---

## 🚀 Fitur Utama

* **Arsitektur Terpisah:** Nginx bertindak murni sebagai *reverse proxy* dan *static file server*, meneruskan request dinamis ke PHP-FPM melalui protokol FastCGI.
* **Production-Ready Config:** Konfigurasi Nginx disesuaikan untuk keamanan (menyembunyikan versi, proteksi akses file sensitif) dan performa.
* **Automation Scripts:** Menyediakan *helper scripts* untuk mempermudah manajemen, *backup*, atau inisialisasi *environment*.
* **Environment Isolated:** Konfigurasi sensitif dipisahkan menggunakan environment variables guna memenuhi standar keamanan modern.

---

## 📁 Struktur Direktori

```text
docker-wordpress-production-lab/
├── nginx/               # Konfigurasi Nginx (server block, fastcgi params)
├── php-fpm/             # Custom Dockerfile & optimalisasi PHP (opcache, upload limits)
├── scripts/             # Script otomatisasi manajemen kontainer
├── .gitignore           # Mengabaikan file sensitif (.env, wp-content lokal)
└── docker-compose.yml   # Orchestration seluruh layanan (Nginx, PHP-FPM, MySQL/MariaDB)
