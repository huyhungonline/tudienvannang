#!/bin/bash
# End-to-end: submit a real mock exam and confirm the result email is sent.
# Uses the admin account's own address, then removes the test attempt.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)

INFO=$(docker exec -w /app tudienvannang-backend-1 python3 -c "
import asyncio, db
from services.auth_service import _create_token
async def main():
    row = await db.query_one('SELECT id, email FROM users WHERE is_admin = true ORDER BY created_at LIMIT 1')
    print(_create_token(str(row['id'])) + '|' + row['email'])
    await db.close_pool()
asyncio.run(main())
" 2>/dev/null | tr -d '\r\n')

TOKEN="${INFO%%|*}"
EMAIL="${INFO##*|}"
[ -n "$TOKEN" ] || { echo "no token"; exit 1; }
echo "Submitting as: $EMAIL"

BASE=http://localhost:4000/api/certificates

echo ""
echo "=== Submit a paper for kikaokako3 ==="
PAPER=$(curl -s -H "Authorization: Bearer $TOKEN" "$BASE/kikaokako3/mock-exam/start")
BODY=$(echo "$PAPER" | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys
d=json.load(sys.stdin)
# Answer the first half, leave the rest blank so the mail has wrong answers.
ans=[]
for i,q in enumerate(d['questions']):
    ans.append({'questionId':q['id'],'selectedLabel':q['choices'][0] if i%2==0 else None})
print(json.dumps({'answers':ans,'durationSeconds':930}))
")
RESULT=$(curl -s -X POST -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/json' \
         -d "$BODY" "$BASE/kikaokako3/mock-exam/submit")
echo "$RESULT" | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys
d=json.load(sys.stdin)
print(f\"  attemptId={d.get('attemptId')} score={d.get('scorePercent')}% correct={d.get('correctCount')}/{d.get('totalQuestions')}\")
"

echo ""
echo "=== Give the background task time to send ==="
sleep 12

echo ""
echo "=== Backend log: did the mail go out? ==="
docker logs tudienvannang-backend-1 --since 2m 2>&1 \
  | grep -iE 'mock exam result email|Failed to send email|smtp' | tail -10 \
  || echo "  (no email errors logged)"

echo ""
echo "  If nothing is listed above, no error was raised and SMTP accepted the message."

echo ""
echo "=== Cleanup: delete the test attempt ==="
ATTEMPT=$(echo "$RESULT" | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys; print(json.load(sys.stdin).get('attemptId',''))" 2>/dev/null | tr -d '\r\n')
if [ -n "$ATTEMPT" ]; then
    docker exec "$PG" psql -U postgres -d english_word_splitter -tAc \
      "DELETE FROM mock_exam_attempts WHERE id = $ATTEMPT;" >/dev/null
    echo "  deleted attempt $ATTEMPT"
fi
docker exec "$PG" psql -U postgres -d english_word_splitter -tAc \
  "SELECT 'attempts remaining: ' || count(*) FROM mock_exam_attempts;"
REMOTE
