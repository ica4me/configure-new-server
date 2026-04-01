# 🧩 Start Server VPS / New Deploy
Linux Debian Base (Debian- Ubuntu Dll)

Rebuild OS (Opsional)
```
# Debian 12
wget https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh && chmod +x reinstall.sh && bash reinstall.sh debian 12 && reboot
```
```
# Ubuntu 22.04
wget https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh && chmod +x reinstall.sh && bash reinstall.sh ubuntu 22.04 && reboot
```
Solv If Error -bash: sudo: command not found
```
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
Setting Global DNS
```
rm -f /etc/resolv.conf
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 1.1.1.1" >> /etc/resolv.conf
systemctl restart systemd-resolved 2>/dev/null || systemctl restart networking 2>/dev/null
```
Update Repo & Install paket dasar
```
 sudo apt update && sudo apt install -y screen wget curl
```

Perbaiki SSH Akses (Izinkan Akses root dan Password Auth)
```
curl -sSL https://raw.githubusercontent.com/ica4me/configure-new-server/main/setup_ssh_remote.sh | bash
```
Mengatur Zona Waktu dan NTP (Asia/Jakarta/WIB)
```
curl -sSL https://raw.githubusercontent.com/ica4me/configure-new-server/main/setup_time.sh | bash
```

Buat Swap Memory (Opsional)
```
wget https://raw.githubusercontent.com/ica4me/make-swap-vps/main/make-swap.sh && chmod +x make-swap.sh && bash make-swap.sh
free -h
```
Install Docker (Jika di butuhkan)
```
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```
