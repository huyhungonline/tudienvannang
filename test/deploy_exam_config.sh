#!/bin/bash
# Deploy the exam-config change: pull, run migration 037, rebuild, then show
# the resulting per-certificate exam format.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1

echo "=== Pulling ==="
git pull origin main || exit 1
echo "HEAD: $(git log --oneline -1)"

PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)

echo ""
echo "=== Running migration 037 ==="
cat backend-python/migrations/037_certificate_exam_config.sql \
    | docker exec -i "$PG" psql -U postgres -d english_word_splitter

echo ""
echo "=== Configured exam format vs question pool ==="
docker exec "$PG" psql -U postgres -d english_word_splitter -P pager=off -c \
"SELECT c.code,
        cfg.question_count   AS real_q,
        cfg.duration_minutes AS mins,
        cfg.required_answers AS must_answer,
        count(q.id)          AS pool,
        LEAST(cfg.question_count, count(q.id)) AS paper_size,
        CASE WHEN count(q.id) < cfg.question_count THEN 'SHORT' ELSE 'ok' END AS status
 FROM certificate_exam_config cfg
 JOIN certificates c ON c.id = cfg.certificate_id
 LEFT JOIN certificate_exam_questions q ON q.certificate_id = cfg.certificate_id
 GROUP BY c.code, cfg.question_count, cfg.duration_minutes, cfg.required_answers
 ORDER BY status DESC, c.code;"

echo ""
echo "=== Rebuilding ==="
docker compose up -d --build 2>&1 | tail -6

echo ""
docker ps --format 'table {{.Names}}\t{{.Status}}'
REMOTE
