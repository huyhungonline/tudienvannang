#!/bin/bash
# Confirm the new "Liên hệ mua sách" button shipped and the /books route works.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
JS=$(docker exec tudienvannang-frontend-1 sh -c 'ls /usr/share/nginx/html/assets/index-*.js' 2>/dev/null | head -1)
CSS=$(docker exec tudienvannang-frontend-1 sh -c 'ls /usr/share/nginx/html/assets/*.css' 2>/dev/null | head -1)
echo "js : $JS"
echo "css: $CSS"
echo ""

check() {
  file="$3"
  n=$(docker exec tudienvannang-frontend-1 sh -c "grep -c -F '$1' $file" 2>/dev/null | head -1)
  n=${n:-0}
  if [ "$2" = "present" ]; then
    if [ "$n" -gt 0 ]; then echo "  FOUND    $1"; else echo "  MISSING  $1"; fi
  else
    if [ "$n" -eq 0 ]; then echo "  absent   $1 (correct)"; else echo "  STILL PRESENT  $1"; fi
  fi
}

echo "=== Bundle contents ==="
check 'Liên hệ mua sách' present "$JS"
check 'certificate-book-btn' present "$JS"
check 'Xem danh sách các chứng chỉ nên luyện thi' present "$JS"
check 'lấy ngẫu nhiên từ kho đề' absent "$JS"
check 'certificate-book-btn' present "$CSS"

echo ""
echo "=== Routes respond ==="
curl -s -o /dev/null -w "  /            -> HTTP %{http_code}\n" --max-time 15 https://taogiaoduc.com/ 2>/dev/null
curl -s -o /dev/null -w "  /books       -> HTTP %{http_code}\n" --max-time 15 https://taogiaoduc.com/books 2>/dev/null
curl -s -o /dev/null -w "  /certificates-> HTTP %{http_code}\n" --max-time 15 https://taogiaoduc.com/certificates 2>/dev/null
curl -s -o /dev/null -w "  /api/books   -> HTTP %{http_code}\n" --max-time 15 http://localhost:4000/api/books 2>/dev/null
REMOTE
