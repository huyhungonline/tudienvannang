#!/bin/bash
# Locate where 450.000 still comes from.
echo "=== Local source ==="
cd "$(dirname "$0")/.." || exit 1
grep -rn '450' --include='*.tsx' --include='*.ts' frontend/src/ | head -10 || echo "  (none in local source)"

echo ""
echo "=== VPS source ==="
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
echo "HEAD: $(git log --oneline -1)"
grep -rn '450' --include='*.tsx' --include='*.ts' frontend/src/ | head -10 || echo "  (none in VPS source)"

echo ""
echo "=== Context around 450.000 in the built bundle ==="
JS=$(docker exec tudienvannang-frontend-1 sh -c 'ls /usr/share/nginx/html/assets/index-*.js' | head -1)
docker exec tudienvannang-frontend-1 sh -c "grep -o '.\{90\}450\.000.\{60\}' $JS" 2>/dev/null | head -3
REMOTE
