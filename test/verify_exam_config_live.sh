#!/bin/bash
# Verify each certificate's mock exam returns a paper of the configured size
# with no duplicate questions, and that randomisation actually varies.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1

TOKEN=$(docker exec -w /app tudienvannang-backend-1 python3 -c "
import asyncio, db
from services.auth_service import _create_token
async def main():
    row = await db.query_one('SELECT id FROM users WHERE is_admin = true ORDER BY created_at LIMIT 1')
    print(_create_token(str(row['id'])) if row else '')
    await db.close_pool()
asyncio.run(main())
" 2>/dev/null | tr -d '\r\n')
[ -n "$TOKEN" ] || { echo "no token"; exit 1; }

BASE=http://localhost:4000/api/certificates
printf '%-16s %-8s %-7s %-7s %-10s %s\n' CODE EXPECT GOT UNIQUE MINS VERDICT
printf '%.0s-' {1..66}; echo

for code in kikaihozen3 seibi2 kikaokako3 seibi3 denkihozen2 denkihozen3 itpp sg kenchikukanri kakakubunseki3; do
    PAPER=$(curl -s -H "Authorization: Bearer $TOKEN" "$BASE/$code/mock-exam/start")
    echo "$PAPER" | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys
code='$code'
try:
    d=json.load(sys.stdin)
    cfg=d['config']; qs=d['questions']
    ids=[q['id'] for q in qs]
    expect=cfg['effectiveCount']; got=len(ids); uniq=len(set(ids))
    verdict='OK' if (got==expect and uniq==got) else 'MISMATCH'
    print(f\"{code:<16} {expect:<8} {got:<7} {uniq:<7} {cfg['durationMinutes']:<10} {verdict}\")
except Exception as e:
    print(f'{code:<16} error: {e}')
"
done

echo ""
echo "=== Randomisation: two papers for kikaihozen3 should differ ==="
A=$(curl -s -H "Authorization: Bearer $TOKEN" "$BASE/kikaihozen3/mock-exam/start")
B=$(curl -s -H "Authorization: Bearer $TOKEN" "$BASE/kikaihozen3/mock-exam/start")
printf '%s\n%s' "$A" "$B" | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys
a,b=[json.loads(l) for l in sys.stdin.read().strip().split(chr(10))]
ia=[q['id'] for q in a['questions']]; ib=[q['id'] for q in b['questions']]
overlap=len(set(ia)&set(ib))
print(f'  paper A: {len(ia)} questions, paper B: {len(ib)} questions')
print(f'  identical order: {ia==ib}')
print(f'  overlap: {overlap}/{len(ia)} (some overlap is expected from a 120-question pool)')
print(f'  duplicates within A: {len(ia)-len(set(ia))}, within B: {len(ib)-len(set(ib))}')
"

echo ""
echo "=== Paper must not leak answers ==="
for f in answerLabel translationVi explanationVi answer_correct; do
    echo "$A" | grep -q "$f" && echo "  LEAK: $f" || echo "  ok: $f absent"
done
REMOTE
