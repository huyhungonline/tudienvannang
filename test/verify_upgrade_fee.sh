#!/bin/bash
# Confirm the served bundle shows the 200.000 fee and no longer mentions 450.000.
# Uses grep -F so the dot in "450.000" is matched literally, not as a wildcard.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
JS=$(docker exec tudienvannang-frontend-1 sh -c 'ls /usr/share/nginx/html/assets/index-*.js' 2>/dev/null | head -1)
echo "bundle: $JS"
echo ""

check() {
  # grep -c prints 0 and exits non-zero on no match, so take only the first
  # line and never append a fallback value.
  n=$(docker exec tudienvannang-frontend-1 sh -c "grep -c -F '$1' $JS" 2>/dev/null | head -1)
  n=${n:-0}
  if [ "$2" = "present" ]; then
    if [ "$n" -gt 0 ]; then echo "  FOUND    $1"; else echo "  MISSING  $1"; fi
  else
    if [ "$n" -eq 0 ]; then echo "  absent   $1 (correct)"; else echo "  STILL PRESENT  $1 ($n matches)"; fi
  fi
}

check '200.000 đồng' present
check '450.000' absent
check 'thi thử chứng chỉ' present
check 'nhập email bạn đã đăng ký tài khoản' present
check '8865150623' present
check 'Tính năng dành cho tài khoản Pro' present

echo ""
echo "=== Site responding ==="
curl -s -o /dev/null -w "  https://taogiaoduc.com -> HTTP %{http_code}\n" --max-time 15 https://taogiaoduc.com/ 2>/dev/null
REMOTE
