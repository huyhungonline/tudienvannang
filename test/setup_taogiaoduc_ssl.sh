#!/usr/bin/env bash
# Run as root on the VPS: bash test/setup_taogiaoduc_ssl.sh
set -euo pipefail

command -v nginx >/dev/null
command -v certbot >/dev/null
nginx -t
curl --fail --silent --output /dev/null http://127.0.0.1:3000

SITE=/etc/nginx/sites-available/taogiaoduc
ENABLED=/etc/nginx/sites-enabled/taogiaoduc
if [ -e "$SITE" ] || [ -e "$ENABLED" ]; then
    echo "Site already exists; inspect it before rerunning this setup."
    exit 1
fi

BACKUP="/root/nginx-backup-taogiaoduc-$(date +%Y%m%d-%H%M%S)"
cp -a /etc/nginx "$BACKUP"
echo "Nginx backup: $BACKUP"

cat > "$SITE" <<'NGINX'
server {
    listen 80;
    server_name taogiaoduc.com www.taogiaoduc.com;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
NGINX

ln -s "$SITE" "$ENABLED"
nginx -t
systemctl reload nginx

# Use the existing Let's Encrypt account already registered on this server.
certbot --nginx --non-interactive --redirect \
    --cert-name taogiaoduc.com -d taogiaoduc.com -d www.taogiaoduc.com
nginx -t
systemctl reload nginx
systemctl is-active certbot.timer
curl --fail --silent --show-error --output /dev/null https://taogiaoduc.com
curl --fail --silent --show-error --output /dev/null https://www.taogiaoduc.com
echo "HTTPS verified for taogiaoduc.com and www.taogiaoduc.com."
