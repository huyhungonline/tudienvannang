#!/bin/bash
# Confirm the long instruction note is gone from the served bundle.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
JS=$(docker exec tudienvannang-frontend-1 sh -c 'ls /usr/share/nginx/html/assets/index-*.js' 2>/dev/null | head -1)
echo "bundle: $JS"
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
check 'lấy ngẫu nhiên từ kho đề' absent
check 'câu nhiều đáp án chọn theo nhãn' absent
check 'Hết thời gian bài thi sẽ tự động được nộp' present

echo ""
curl -s -o /dev/null -w "  https://taogiaoduc.com -> HTTP %{http_code}\n" --max-time 15 https://taogiaoduc.com/ 2>/dev/null
REMOTE
