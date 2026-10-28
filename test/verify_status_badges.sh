#!/bin/bash
# Confirm the status badges shipped and the old emoji toggles are gone.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
JS=$(docker exec tudienvannang-frontend-1 sh -c 'ls /usr/share/nginx/html/assets/index-*.js' 2>/dev/null | head -1)
CSS=$(docker exec tudienvannang-frontend-1 sh -c 'ls /usr/share/nginx/html/assets/*.css' 2>/dev/null | head -1)

check() {
  n=$(docker exec tudienvannang-frontend-1 sh -c "grep -c -F '$1' $3" 2>/dev/null | head -1)
  n=${n:-0}
  if [ "$2" = "present" ]; then
    [ "$n" -gt 0 ] && echo "  FOUND    $1" || echo "  MISSING  $1"
  else
    [ "$n" -eq 0 ] && echo "  absent   $1 (correct)" || echo "  STILL PRESENT  $1"
  fi
}

echo "=== Bundle ==="
check 'Đã thu' present "$JS"
check 'Chưa thu' present "$JS"
check 'Đã gửi' present "$JS"
check 'status-pill' present "$JS"
check 'status-pill' present "$CSS"
check 'status-pill-spin' present "$CSS"

echo ""
echo "=== Old emoji toggles removed ==="
check '📦' absent "$JS"
check '⬜' absent "$JS"

echo ""
curl -s -o /dev/null -w "  https://taogiaoduc.com/admin -> HTTP %{http_code}\n" --max-time 15 https://taogiaoduc.com/admin 2>/dev/null
REMOTE
