#!/bin/bash
# Confirm the standalone workbook entry shipped and the target page works.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
JS=$(docker exec tudienvannang-frontend-1 sh -c 'ls /usr/share/nginx/html/assets/index-*.js' 2>/dev/null | head -1)

n=$(docker exec tudienvannang-frontend-1 sh -c "grep -c -F 'Đăng kí in sách bài tập IT Passport' $JS" 2>/dev/null | head -1)
[ "${n:-0}" -gt 0 ] && echo "  FOUND    new menu entry" || echo "  MISSING  new menu entry"

echo ""
echo "=== Routes ==="
for p in /dang-ki-lop-hoc /dang-ki-in-sach-bai-tap; do
  code=$(curl -s -o /dev/null -w '%{http_code}' --max-time 15 "https://taogiaoduc.com$p")
  echo "  $p -> HTTP $code"
done
REMOTE
