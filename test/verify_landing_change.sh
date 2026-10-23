#!/bin/bash
# Confirm the landing page is now Professional Books with the mock exam CTA,
# and that the certificate section is still reachable.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
JS=$(docker exec tudienvannang-frontend-1 sh -c 'ls /usr/share/nginx/html/assets/index-*.js' 2>/dev/null | head -1)
CSS=$(docker exec tudienvannang-frontend-1 sh -c 'ls /usr/share/nginx/html/assets/*.css' 2>/dev/null | head -1)
echo "js : $JS"
echo "css: $CSS"
echo ""

check() {
  n=$(docker exec tudienvannang-frontend-1 sh -c "grep -c -F '$1' $3" 2>/dev/null | head -1)
  n=${n:-0}
  if [ "$2" = "present" ]; then
    if [ "$n" -gt 0 ]; then echo "  FOUND    $1"; else echo "  MISSING  $1"; fi
  else
    if [ "$n" -eq 0 ]; then echo "  absent   $1 (correct)"; else echo "  STILL PRESENT  $1"; fi
  fi
}

echo "=== Bundle ==="
check 'Thi thử ngay!' present "$JS"
check 'btn-mock-exam-cta' present "$JS"
check 'Professional Books' present "$JS"
check 'Thi chứng chỉ tại Nhật' present "$JS"
check 'btn-mock-exam-cta' present "$CSS"
check 'mock-exam-cta' present "$CSS"

echo ""
echo "=== Routes respond ==="
for p in / /books /certificates /certificates/cokhi /tra-cuu; do
  curl -s -o /dev/null -w "  %-28s -> HTTP %{http_code}\n" --max-time 15 "https://taogiaoduc.com$p" 2>/dev/null \
    | sed "s|%-28s|$p|"
done

echo ""
echo "=== Landing HTML served (SPA shell) ==="
curl -s --max-time 15 https://taogiaoduc.com/ 2>/dev/null | grep -o '<title>[^<]*</title>' | head -1
REMOTE
