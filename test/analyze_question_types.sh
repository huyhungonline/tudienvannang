#!/bin/bash
# Read-only: figure out how true/false vs multiple-choice questions are stored.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
DB=english_word_splitter
p() { docker exec "$PG" psql -U postgres -d "$DB" -P pager=off -c "$1" 2>&1; }

echo "=== 1. How are answer_correct / answer_label populated? ==="
p "SELECT
     CASE WHEN answer_correct IS NULL THEN 'answer_correct NULL' ELSE 'answer_correct SET' END AS bool_col,
     CASE WHEN answer_label IS NULL OR answer_label = '' THEN 'answer_label EMPTY' ELSE 'answer_label SET' END AS label_col,
     count(*) AS questions
   FROM certificate_exam_questions
   GROUP BY 1,2 ORDER BY 3 DESC;"

echo ""
echo "=== 2. Distinct answer_label values (how choices are expressed) ==="
p "SELECT answer_label, count(*) AS n
   FROM certificate_exam_questions
   WHERE answer_label IS NOT NULL AND answer_label <> ''
   GROUP BY answer_label ORDER BY n DESC LIMIT 30;"

echo ""
echo "=== 3. Which certificates use which style? ==="
p "SELECT c.code, c.category,
     count(*) FILTER (WHERE q.answer_label IS NULL OR q.answer_label = '') AS truefalse_style,
     count(*) FILTER (WHERE q.answer_label IS NOT NULL AND q.answer_label <> '') AS labelled_style,
     count(*) AS total
   FROM certificate_exam_questions q
   JOIN certificates c ON c.id = q.certificate_id
   GROUP BY c.code, c.category ORDER BY c.category, c.code;"

echo ""
echo "=== 4. Sample: true/false style (no answer_label) ==="
p "SELECT id, certificate_id, question_no, answer_correct, answer_label,
     left(question_ja, 70) AS question_ja_head
   FROM certificate_exam_questions
   WHERE answer_label IS NULL OR answer_label = ''
   ORDER BY id LIMIT 3;"

echo ""
echo "=== 5. Sample: multiple-choice style (has answer_label) ==="
p "SELECT id, certificate_id, question_no, answer_correct, answer_label,
     left(question_ja, 70) AS question_ja_head
   FROM certificate_exam_questions
   WHERE answer_label IS NOT NULL AND answer_label <> ''
   ORDER BY id LIMIT 3;"
REMOTE
