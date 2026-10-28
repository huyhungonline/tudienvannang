#!/bin/bash
# Confirm the redesigned CTA shipped.
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

echo "=== New CTA content ==="
check 'Thi thử miễn phí' present "$JS"
check 'Luyện thi chứng chỉ Nhật' present "$JS"
check 'Giảm chi phí thi lại nhiều lần' present "$JS"
check 'mock-exam-cta-badge' present "$JS"
check 'mock-exam-cta-points' present "$JS"

echo ""
echo "=== Old wording removed ==="
check 'Bấm vào để thi thử ngay' absent "$JS"
check 'mock-exam-cta-sub' absent "$CSS"

echo ""
echo "=== New styles present ==="
check 'mock-exam-cta-badge' present "$CSS"
check 'btn-mock-exam-arrow' present "$CSS"
check 'mock-exam-cta-title' present "$CSS"

echo ""
curl -s -o /dev/null -w "  https://taogiaoduc.com -> HTTP %{http_code}\n" --max-time 15 https://taogiaoduc.com/ 2>/dev/null
REMOTE
