#!/bin/bash

echo "=== 1. Memeriksa Instalasi SSH Server ==="
# Mengecek apakah openssh-server sudah terinstal di sistem Debian/Ubuntu
if ! dpkg -s openssh-server >/dev/null 2>&1; then
    echo "[!] SSH server belum terinstal. Memulai proses instalasi..."
    sudo apt-get update -y
    sudo apt-get install -y openssh-server
    echo "[v] Instalasi SSH server selesai."
else
    echo "[v] SSH server sudah terinstal."
fi

echo -e "\n=== 2. Mengonfigurasi Direktori & File Include ==="
# Pastikan direktori sshd_config.d ada
sudo mkdir -p /etc/ssh/sshd_config.d

# Tambahkan baris Include ke sshd_config (tanpa duplikasi)
grep -qxF 'Include /etc/ssh/sshd_config.d/90_overwrite.conf' /etc/ssh/sshd_config || echo 'Include /etc/ssh/sshd_config.d/90_overwrite.conf' | sudo tee -a /etc/ssh/sshd_config > /dev/null
echo "[v] Konfigurasi Include dipastikan ada di sshd_config."

echo -e "\n=== 3. Menulis Aturan Override (Port & Autentikasi) ==="
# Buat dan isi file 90_overwrite.conf
sudo tee /etc/ssh/sshd_config.d/90_overwrite.conf > /dev/null <<EOF
Port 22
Port 2026
PermitRootLogin yes
PasswordAuthentication yes
EOF
echo "[v] File 90_overwrite.conf berhasil dibuat."

echo -e "\n=== 4. Me-restart Service SSH ==="
# Restart service SSH untuk menerapkan konfigurasi (mendukung lingkungan Debian/Ubuntu maupun varian lain)
if sudo systemctl restart ssh 2>/dev/null || sudo systemctl restart sshd 2>/dev/null; then
    echo "[v] Service SSH berhasil di-restart."
    echo -e "\n=== SELESAI ==="
    echo "SSH sekarang berjalan dan mendengarkan di Port 22 dan Port 2026."
    echo "Akses root dan autentikasi password telah diizinkan."
else
    echo "[X] Gagal me-restart service SSH. Silakan periksa status menggunakan: systemctl status ssh"
fi
