#!/bin/bash
# Read-only: show schema of the question tables and a sanitised sample.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
DB=english_word_splitter
psqlc() { docker exec "$PG" psql -U postgres -d "$DB" -c "$1" 2>/dev/null; }
q() { docker exec "$PG" psql -U postgres -d "$DB" -tAc "$1" 2>/dev/null; }

for t in certificate_exam_questions classroom_questions certificates; do
    echo "============================================================"
    echo "TABLE: $t   ($(q "SELECT count(*) FROM $t;") rows)"
    echo "============================================================"
    psqlc "\d $t"
    echo ""
done

echo "============================================================"
echo "certificates (the exam categories)"
echo "============================================================"
psqlc "SELECT * FROM certificates ORDER BY id;"

echo "============================================================"
echo "Question count per certificate"
echo "============================================================"
psqlc "SELECT c.id, c.name, count(q.id) AS questions
       FROM certificates c
       LEFT JOIN certificate_exam_questions q ON q.certificate_id = c.id
       GROUP BY c.id, c.name ORDER BY c.id;"
REMOTE
