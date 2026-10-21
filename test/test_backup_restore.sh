#!/bin/bash
# Verify a backup in S3 is actually restorable.
# Restores into a temporary database, compares table counts with production,
# then drops the temp database. Production data is never written to.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
set -a
. ./.env
set +a
export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION="$AWS_REGION"

PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
TMPDB="restore_verify_$(date +%s)"

LATEST=$(aws s3 ls "s3://${S3_BACKUP_BUCKET}/postgres/" --recursive \
         | sort | tail -1 | awk '{print $4}')
echo "Latest backup: $LATEST"
[ -n "$LATEST" ] || { echo "no backup found"; exit 1; }

echo ""
echo "--- downloading ---"
aws s3 cp "s3://${S3_BACKUP_BUCKET}/${LATEST}" /tmp/verify.sql.gz --only-show-errors
ls -lh /tmp/verify.sql.gz | awk '{print "size:", $5}'

echo ""
echo "--- restoring into temp db: $TMPDB ---"
docker exec "$PG" psql -U "$POSTGRES_USER" -d postgres -c "CREATE DATABASE $TMPDB;" >/dev/null
if gunzip -c /tmp/verify.sql.gz | docker exec -i "$PG" psql -U "$POSTGRES_USER" -d "$TMPDB" >/tmp/restore.out 2>/tmp/restore.err; then
    echo "restore completed"
else
    echo "restore reported errors:"
    tail -5 /tmp/restore.err
fi

echo ""
echo "--- comparing row counts (production vs restored) ---"
for t in users word_dictionary word_dictionary_multilang reading_posts public_searches; do
    a=$(docker exec "$PG" psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -tAc "SELECT count(*) FROM $t" 2>/dev/null || echo "n/a")
    b=$(docker exec "$PG" psql -U "$POSTGRES_USER" -d "$TMPDB" -tAc "SELECT count(*) FROM $t" 2>/dev/null || echo "n/a")
    if [ "$a" = "$b" ]; then
        printf '  %-30s prod=%-8s restored=%-8s MATCH\n' "$t" "$a" "$b"
    else
        printf '  %-30s prod=%-8s restored=%-8s DIFFERENT\n' "$t" "$a" "$b"
    fi
done

echo ""
echo "--- cleaning up ---"
docker exec "$PG" psql -U "$POSTGRES_USER" -d postgres -c "DROP DATABASE $TMPDB;" >/dev/null
rm -f /tmp/verify.sql.gz /tmp/restore.out /tmp/restore.err
echo "temp database dropped"
REMOTE
