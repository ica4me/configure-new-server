#!/bin/bash

# 1. Pastikan script dijalankan sebagai root
if [ "$EUID" -ne 0 ]; then
  echo "Error: Tolong jalankan script ini sebagai root."
  exit 1
fi

echo "=== 1. Mengatur Timezone ke Asia/Jakarta (WIB) ==="
timedatectl set-timezone Asia/Jakarta
echo "Timezone saat ini:"
timedatectl | grep "Time zone"

echo -e "\n=== 2. Memastikan Paket NTP Terinstal ==="
# Update repository lokal dan install paket ntp
apt-get update -y
apt-get install -y ntp ntpstat

# Debian 12 dan Ubuntu terbaru kadang menggunakan direktori ntpsec
NTP_CONF="/etc/ntp.conf"
if [ -f "/etc/ntpsec/ntp.conf" ]; then
    NTP_CONF="/etc/ntpsec/ntp.conf"
fi

echo -e "\n=== 3. Mengonfigurasi $NTP_CONF ==="
# Backup konfigurasi bawaan jika belum ada backup
if [ ! -f "${NTP_CONF}.bak" ]; then
    cp "$NTP_CONF" "${NTP_CONF}.bak"
    echo "Backup file konfigurasi asli disimpan di ${NTP_CONF}.bak"
fi

# Mengomentari (disable) server/pool bawaan agar tidak bentrok dengan pool ID
sed -i 's/^pool /#pool /g' "$NTP_CONF"
sed -i 's/^server /#server /g' "$NTP_CONF"

# Mengecek apakah pool ID sudah ada untuk mencegah duplikasi jika script dijalankan 2x
if ! grep -q "0.id.pool.ntp.org" "$NTP_CONF"; then
    echo -e "\n# Server NTP Pool Indonesia" >> "$NTP_CONF"
    echo "server 0.id.pool.ntp.org iburst" >> "$NTP_CONF"
    echo "server 1.id.pool.ntp.org iburst" >> "$NTP_CONF"
    echo "server 2.id.pool.ntp.org iburst" >> "$NTP_CONF"
    echo "server 3.id.pool.ntp.org iburst" >> "$NTP_CONF"
    echo "NTP server Indonesia berhasil ditambahkan."
else
    echo "NTP server Indonesia sudah terkonfigurasi di file."
fi

echo -e "\n=== 4. Me-restart Service NTP ==="
# Mendeteksi nama service yang aktif (ntp atau ntpsec)
if systemctl list-unit-files | grep -q ntpsec.service; then
    systemctl restart ntpsec
    systemctl enable ntpsec
else
    systemctl restart ntp
    systemctl enable ntp
fi

echo "Service NTP berhasil di-restart dan diaktifkan pada saat boot."

echo -e "\n=== 5. Verifikasi Status Sinkronisasi ==="
# Memberi jeda sebentar agar service sempat terhubung ke server
sleep 3
ntpq -p

echo -e "\n=== Selesai! Waktu server saat ini: ==="
date
