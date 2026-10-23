#!/bin/bash
# Confirm the new CTA wording shipped and the old wording is gone.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
JS=$(docker exec tudienvannang-frontend-1 sh -c 'ls /usr/share/nginx/html/assets/index-*.js' 2>/dev/null | head -1)
echo "js: $JS"
echo ""

check() {
  n=$(docker exec tudienvannang-frontend-1 sh -c "grep -c -F '$1' $JS" 2>/dev/null | head -1)
  n=${n:-0}
  if [ "$2" = "present" ]; then
    if [ "$n" -gt 0 ]; then echo "  FOUND    $1"; else echo "  MISSING  $1"; fi
  else
    if [ "$n" -eq 0 ]; then echo "  absent   $1 (correct)"; else echo "  STILL PRESENT  $1"; fi
  fi
}

echo "=== New copy ==="
check 'Bấm vào để thi thử ngay' present
check 'nội dung và phương thức thi giống đề thi thật' present
check 'Giảm chi phí thi nhiều lần!' present
check 'kết quả sẽ được thông báo qua mail' present

echo ""
echo "=== Old copy removed ==="
check 'Thi thử ngay!' absent
check 'từ vựng chuyên ngành, giải đề các năm và thi thử có chấm điểm' absent

echo ""
curl -s -o /dev/null -w "  https://taogiaoduc.com -> HTTP %{http_code}\n" --max-time 15 https://taogiaoduc.com/ 2>/dev/null
REMOTE
