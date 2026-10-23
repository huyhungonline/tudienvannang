#!/bin/bash
# Read-only: question count per certificate, grouped by category.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
DB=english_word_splitter

echo "=== Questions per certificate ==="
docker exec "$PG" psql -U postgres -d "$DB" -P pager=off -c \
"SELECT c.id, c.code, c.category, c.name_vi, count(q.id) AS questions
 FROM certificates c
 LEFT JOIN certificate_exam_questions q ON q.certificate_id = c.id
 GROUP BY c.id, c.code, c.category, c.name_vi
 ORDER BY c.category, c.id;" 2>&1

echo ""
echo "=== Totals per category ==="
docker exec "$PG" psql -U postgres -d "$DB" -P pager=off -c \
"SELECT c.category, count(DISTINCT c.id) AS certs, count(q.id) AS questions
 FROM certificates c
 LEFT JOIN certificate_exam_questions q ON q.certificate_id = c.id
 GROUP BY c.category ORDER BY c.category;" 2>&1

echo ""
echo "=== Exam years / rounds available ==="
docker exec "$PG" psql -U postgres -d "$DB" -P pager=off -c \
"SELECT certificate_id, exam_year, count(*) AS questions
 FROM certificate_exam_questions
 GROUP BY certificate_id, exam_year
 ORDER BY certificate_id, exam_year;" 2>&1

echo ""
echo "=== Vocabulary per certificate ==="
docker exec "$PG" psql -U postgres -d "$DB" -P pager=off -c \
"SELECT certificate_id, count(*) AS vocab_rows
 FROM certificate_vocabulary GROUP BY certificate_id ORDER BY certificate_id;" 2>&1
REMOTE
