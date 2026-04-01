<div align="center">

# 🧩 Start Server VPS / New Deploy
### Linux Debian Base · Debian · Ubuntu · VPS Bootstrap

<p>
  <a href="#-rebuild-os-opsional"><img src="https://img.shields.io/badge/Rebuild%20OS-Optional-6f42c1?style=for-the-badge&logo=linux&logoColor=white" alt="Rebuild OS" /></a>
  <a href="#-solusi-jika-muncul-error--bash-sudo-command-not-found"><img src="https://img.shields.io/badge/Fix-sudo%20not%20found-dc3545?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Fix sudo" /></a>
  <a href="#-setting-global-dns"><img src="https://img.shields.io/badge/Set-Global%20DNS-0d6efd?style=for-the-badge&logo=cloudflare&logoColor=white" alt="Global DNS" /></a>
  <a href="#-update-repo--install-paket-dasar"><img src="https://img.shields.io/badge/Install-Basic%20Packages-198754?style=for-the-badge&logo=debian&logoColor=white" alt="Basic Packages" /></a>
</p>

<p>
  <a href="#-perbaiki-ssh-akses-izinkan-akses-root-dan-password-auth"><img src="https://img.shields.io/badge/Configure-SSH-111827?style=for-the-badge&logo=openssh&logoColor=white" alt="Configure SSH" /></a>
  <a href="#-mengatur-zona-waktu-dan-ntp-asiajakartawib"><img src="https://img.shields.io/badge/Timezone-Asia%2FJakarta-f59e0b?style=for-the-badge&logo=googlecalendar&logoColor=white" alt="Timezone Asia Jakarta" /></a>
  <a href="#-buat-swap-memory-opsional"><img src="https://img.shields.io/badge/Create-Swap%20Memory-20c997?style=for-the-badge&logo=buffer&logoColor=white" alt="Swap Memory" /></a>
  <a href="#-install-docker-jika-dibutuhkan"><img src="https://img.shields.io/badge/Install-Docker-2496ed?style=for-the-badge&logo=docker&logoColor=white" alt="Install Docker" /></a>
</p>

<p>
  <img src="https://img.shields.io/badge/OS-Debian%2012%20%7C%20Ubuntu%2022.04-232f3e?style=flat-square&logo=linux&logoColor=white" alt="OS Support" />
  <img src="https://img.shields.io/badge/Timezone-WIB%20(Asia%2FJakarta)-ff9800?style=flat-square&logo=clockify&logoColor=white" alt="Timezone" />
  <img src="https://img.shields.io/badge/Network-DNS%208.8.8.8%20%7C%201.1.1.1-1f6feb?style=flat-square&logo=googlecloud&logoColor=white" alt="DNS" />
  <img src="https://img.shields.io/badge/Container-Docker-2496ed?style=flat-square&logo=docker&logoColor=white" alt="Docker" />
</p>

</div>

---

## ✨ Ringkasan
Panduan ini dipakai untuk menyiapkan VPS baru berbasis **Debian / Ubuntu** agar cepat siap digunakan: mulai dari rebuild OS, perbaikan `sudo`, pengaturan DNS, instalasi paket dasar, konfigurasi SSH, sinkronisasi waktu, pembuatan swap, hingga instalasi Docker.

> 💡 **Tips:** Jalankan perintah satu per satu dan pastikan Anda memahami efeknya sebelum mengeksekusi script dari internet.

---

## 🗂️ Navigasi Cepat
| Langkah | Fungsi | Aksi |
|---|---|---|
| 1 | Rebuild sistem operasi | [Lihat](#-rebuild-os-opsional) |
| 2 | Perbaiki error `sudo` | [Lihat](#-solusi-jika-muncul-error--bash-sudo-command-not-found) |
| 3 | Atur DNS global | [Lihat](#-setting-global-dns) |
| 4 | Update repo & paket dasar | [Lihat](#-update-repo--install-paket-dasar) |
| 5 | Perbaiki akses SSH | [Lihat](#-perbaiki-ssh-akses-izinkan-akses-root-dan-password-auth) |
| 6 | Set zona waktu & NTP | [Lihat](#-mengatur-zona-waktu-dan-ntp-asiajakartawib) |
| 7 | Buat swap memory | [Lihat](#-buat-swap-memory-opsional) |
| 8 | Install Docker | [Lihat](#-install-docker-jika-dibutuhkan) |

---

## 🧱 Rebuild OS (Opsional)
<details>
<summary><strong>Klik untuk membuka perintah rebuild OS</strong></summary>
<br>

### Debian 12
```bash
wget https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh && chmod +x reinstall.sh && bash reinstall.sh debian 12 && reboot
```

### Ubuntu 22.04
```bash
wget https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh && chmod +x reinstall.sh && bash reinstall.sh ubuntu 22.04 && reboot
```

</details>

<p align="right"><a href="#-start-server-vps--new-deploy">⬆️ Kembali ke atas</a></p>

---

## 🛠️ Solusi Jika Muncul Error `-bash: sudo: command not found`
<details>
<summary><strong>Klik untuk membuka script perbaikan sudo</strong></summary>
<br>

```bash
cat <<'EOF' > /usr/local/bin/sudo && chmod +x /usr/local/bin/sudo
#!/bin/sh
if command -v /usr/bin/sudo >/dev/null 2>&1; then
    exec /usr/bin/sudo "$@"
fi
if [ "$(id -u)" -eq 0 ]; then
    exec "$@"
fi
echo "sudo not installed and you are not root" >&2
exit 1
EOF
```

</details>

<p align="right"><a href="#-start-server-vps--new-deploy">⬆️ Kembali ke atas</a></p>

---

## 🌐 Setting Global DNS
<details>
<summary><strong>Klik untuk membuka perintah DNS</strong></summary>
<br>

```bash
rm -f /etc/resolv.conf
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 1.1.1.1" >> /etc/resolv.conf
systemctl restart systemd-resolved 2>/dev/null || systemctl restart networking 2>/dev/null
```

</details>

<p align="right"><a href="#-start-server-vps--new-deploy">⬆️ Kembali ke atas</a></p>

---

## 📦 Update Repo & Install Paket Dasar
<details>
<summary><strong>Klik untuk membuka perintah instalasi paket dasar</strong></summary>
<br>

```bash
sudo apt update && sudo apt install -y screen wget curl
```

</details>

<p align="right"><a href="#-start-server-vps--new-deploy">⬆️ Kembali ke atas</a></p>

---

## 🔐 Perbaiki SSH Akses (Izinkan Akses root dan Password Auth)
<details>
<summary><strong>Klik untuk membuka perintah setup SSH</strong></summary>
<br>

```bash
curl -sSL https://raw.githubusercontent.com/ica4me/configure-new-server/main/setup_ssh_remote.sh | bash
```

</details>

<p align="right"><a href="#-start-server-vps--new-deploy">⬆️ Kembali ke atas</a></p>

---

## 🕒 Mengatur Zona Waktu dan NTP (`Asia/Jakarta` / WIB)
<details>
<summary><strong>Klik untuk membuka perintah setup waktu</strong></summary>
<br>

```bash
curl -sSL https://raw.githubusercontent.com/ica4me/configure-new-server/main/setup_time.sh | bash
```

</details>

<p align="right"><a href="#-start-server-vps--new-deploy">⬆️ Kembali ke atas</a></p>

---

## 💾 Buat Swap Memory (Opsional)
<details>
<summary><strong>Klik untuk membuka perintah pembuatan swap</strong></summary>
<br>

```bash
wget https://raw.githubusercontent.com/ica4me/make-swap-vps/main/make-swap.sh && chmod +x make-swap.sh && bash make-swap.sh
free -h
```

</details>

<p align="right"><a href="#-start-server-vps--new-deploy">⬆️ Kembali ke atas</a></p>

---

## 🐳 Install Docker (Jika Dibutuhkan)
<details>
<summary><strong>Klik untuk membuka perintah instalasi Docker</strong></summary>
<br>

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```

</details>

<p align="right"><a href="#-start-server-vps--new-deploy">⬆️ Kembali ke atas</a></p>

---

## ✅ Checklist Selesai Deploy
- [ ] OS sudah sesuai kebutuhan
- [ ] DNS global sudah aktif
- [ ] Paket dasar (`screen`, `wget`, `curl`) sudah terpasang
- [ ] SSH root / password auth sudah disesuaikan
- [ ] Zona waktu sudah **Asia/Jakarta**
- [ ] NTP sinkron
- [ ] Swap aktif bila diperlukan
- [ ] Docker terpasang bila diperlukan

---

## 📌 Catatan
- Bagian yang dapat diklik memakai elemen `<details>` agar README lebih rapi.
- Badge di bagian atas berfungsi sebagai navigasi cepat ke setiap section.
- Struktur ini cocok untuk README GitHub, dokumentasi internal, atau catatan deploy pribadi.
