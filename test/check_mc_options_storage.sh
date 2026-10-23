#!/bin/bash
# Read-only: determine whether multiple-choice options are stored anywhere.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
DB=english_word_splitter
p() { docker exec "$PG" psql -U postgres -d "$DB" -P pager=off -c "$1" 2>&1; }

echo "=== Does question_ja embed the choices inline? ==="
p "SELECT id, length(question_ja) AS len,
     (question_ja LIKE '%ア%' AND question_ja LIKE '%イ%') AS has_a_i_markers
   FROM certificate_exam_questions
   WHERE answer_correct IS NULL
   ORDER BY id LIMIT 5;"

echo ""
echo "=== Full text of one multiple-choice question (ITPP) ==="
p "SELECT question_ja FROM certificate_exam_questions
   WHERE answer_correct IS NULL AND certificate_id = 9 ORDER BY id LIMIT 1;"

echo ""
echo "=== Its Vietnamese translation ==="
p "SELECT translation_vi FROM certificate_exam_questions
   WHERE answer_correct IS NULL AND certificate_id = 9 ORDER BY id LIMIT 1;"

echo ""
echo "=== How many MC questions contain inline choice markers? ==="
p "SELECT
     count(*) AS mc_total,
     count(*) FILTER (WHERE question_ja LIKE '%ア%' AND question_ja LIKE '%イ%') AS with_a_i,
     count(*) FILTER (WHERE question_ja ~ '\(1\)' AND question_ja ~ '\(2\)') AS with_numbered
   FROM certificate_exam_questions
   WHERE answer_correct IS NULL;"

echo ""
echo "=== vocab_json shape (is it used for options?) ==="
p "SELECT id, jsonb_typeof(vocab_json) AS type,
     jsonb_array_length(vocab_json) AS items
   FROM certificate_exam_questions
   WHERE answer_correct IS NULL ORDER BY id LIMIT 3;"

echo ""
echo "=== Sample vocab_json content ==="
p "SELECT jsonb_pretty(vocab_json) FROM certificate_exam_questions
   WHERE answer_correct IS NULL AND jsonb_array_length(vocab_json) > 0
   ORDER BY id LIMIT 1;"
REMOTE
