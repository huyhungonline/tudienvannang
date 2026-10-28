#!/bin/bash
# Read-only overview of things that may need attention.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
q() { docker exec "$PG" psql -U postgres -d english_word_splitter -tAc "$1" 2>/dev/null; }

echo "=== Containers ==="
docker ps --format '  {{.Names}}  {{.Status}}'

echo ""
echo "=== Disk ==="
df -h / | tail -1 | awk '{print "  used "$3" of "$2" ("$5"), "$4" free"}'
echo "  backups dir: $(du -sh backups 2>/dev/null | cut -f1)"

echo ""
echo "=== Class registration availability (public view) ==="
q "SELECT '  ' || s.name || ' -> ' ||
          (SELECT COUNT(*) FROM class_registrations r
            WHERE r.course=s.course AND r.schedule=s.code) || '/' || s.capacity ||
          CASE WHEN s.is_active THEN ' (mở)' ELSE ' (đóng)' END
   FROM class_sessions s ORDER BY s.sort_order;"
OPEN=$(q "SELECT COUNT(*) FROM class_sessions s WHERE s.is_active
          AND (SELECT COUNT(*) FROM class_registrations r
                WHERE r.course=s.course AND r.schedule=s.code) < s.capacity;")
echo "  classes a visitor can actually join: $OPEN"

echo ""
echo "=== Mock exam question pool vs configured paper size ==="
q "SELECT '  ' || c.code || ': cần ' || cfg.question_count || ', có ' || COUNT(q.id)
   FROM certificate_exam_config cfg
   JOIN certificates c ON c.id = cfg.certificate_id
   LEFT JOIN certificate_exam_questions q ON q.certificate_id = cfg.certificate_id
   GROUP BY c.code, cfg.question_count
   HAVING COUNT(q.id) < cfg.question_count;"
echo "  (only certificates short of questions are listed)"

echo ""
echo "=== Recent backups in S3 ==="
set -a; . ./.env; set +a
export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION="$AWS_REGION"
aws s3 ls "s3://${S3_BACKUP_BUCKET}/postgres/" --recursive | tail -3 | sed 's/^/  /'
echo "  IAM identity in use: $(aws sts get-caller-identity --query Arn --output text 2>/dev/null)"

echo ""
echo "=== Last backup log ==="
tail -3 backups/backup.log 2>/dev/null | sed 's/^/  /'
REMOTE
