#!/bin/bash
# End-to-end check of the deployed mock exam API using a real admin token.
# Creates a temporary attempt, then removes it so production data stays clean.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
set -a; . ./.env; set +a

echo "=== Containers ==="
docker ps --format '  {{.Names}} {{.Status}}'

echo ""
echo "=== Mint a short-lived admin token for testing ==="
TOKEN=$(docker exec -w /app tudienvannang-backend-1 python3 -c "
import asyncio, db
from services.auth_service import _create_token
async def main():
    row = await db.query_one('SELECT id FROM users WHERE is_admin = true ORDER BY created_at LIMIT 1')
    print(_create_token(str(row['id'])) if row else '')
    await db.close_pool()
asyncio.run(main())
" 2>/dev/null | tr -d '\r\n')

if [ -z "$TOKEN" ]; then
    echo "  could not mint token; skipping authenticated checks"
    exit 1
fi
echo "  token acquired (${#TOKEN} chars)"

AUTH="Authorization: Bearer $TOKEN"
BASE=http://localhost:4000/api/certificates

echo ""
echo "=== 1. GET sessions (kikaokako3) ==="
curl -s -H "$AUTH" "$BASE/kikaokako3/mock-exam/sessions" | head -c 400
echo ""

echo ""
echo "=== 2. GET start (5 questions) ==="
PAPER=$(curl -s -H "$AUTH" "$BASE/kikaokako3/mock-exam/start?limit=5")
echo "$PAPER" | head -c 600
echo ""
echo ""
echo "  Does the paper leak answers? (must be none)"
for field in answerLabel answer_label translationVi explanationVi answer_correct; do
    if echo "$PAPER" | grep -q "$field"; then
        echo "    LEAK: $field present in start response"
    else
        echo "    ok: $field absent"
    fi
done

echo ""
echo "=== 3. POST submit (answer every question with the first choice) ==="
BODY=$(echo "$PAPER" | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys
d=json.load(sys.stdin)
ans=[{'questionId':q['id'],'selectedLabel':q['choices'][0]} for q in d['questions']]
print(json.dumps({'answers':ans,'durationSeconds':42}))
")
RESULT=$(curl -s -X POST -H "$AUTH" -H 'Content-Type: application/json' \
         -d "$BODY" "$BASE/kikaokako3/mock-exam/submit")
echo "$RESULT" | head -c 500
echo ""
echo ""
echo "  Summary fields:"
echo "$RESULT" | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys
d=json.load(sys.stdin)
print(f\"    attemptId={d.get('attemptId')} total={d.get('totalQuestions')} correct={d.get('correctCount')} score={d.get('scorePercent')}%\")
print(f\"    results returned: {len(d.get('results',[]))}\")
r=d.get('results',[{}])[0]
print(f\"    first result has explanation: {bool(r.get('explanationVi'))}, correctLabel={r.get('correctLabel')!r}\")
" 2>/dev/null

echo ""
echo "=== 4. GET history ==="
curl -s -H "$AUTH" "$BASE/kikaokako3/mock-exam/history" | head -c 300
echo ""

echo ""
echo "=== 5. Cleanup: remove the test attempt ==="
ATTEMPT=$(echo "$RESULT" | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys; print(json.load(sys.stdin).get('attemptId',''))" 2>/dev/null | tr -d '\r\n')
if [ -n "$ATTEMPT" ]; then
    docker exec "$PG" psql -U postgres -d english_word_splitter -tAc \
      "DELETE FROM mock_exam_attempts WHERE id = $ATTEMPT;" >/dev/null
    echo "  deleted attempt $ATTEMPT"
    docker exec "$PG" psql -U postgres -d english_word_splitter -tAc \
      "SELECT 'remaining attempts: ' || count(*) FROM mock_exam_attempts;"
fi

echo ""
echo "=== 6. Unauthenticated access must be refused ==="
curl -s -o /dev/null -w "  no token -> HTTP %{http_code}\n" "$BASE/kikaokako3/mock-exam/start?limit=1"
REMOTE
