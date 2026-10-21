#!/bin/bash
# Restore a PostgreSQL backup from S3.
#
# Usage:
#   bash restore-db-s3.sh --list                 # show available backups
#   bash restore-db-s3.sh <s3-key>               # restore a specific backup
#
# WARNING: restoring overwrites data in the target database.

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

[ -f "${PROJECT_DIR}/.env" ] || { echo "ERROR: .env not found"; exit 1; }
set -a
# shellcheck disable=SC1091
. "${PROJECT_DIR}/.env"
set +a

: "${POSTGRES_USER:=postgres}"
: "${POSTGRES_DB:=english_word_splitter}"
export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION="${AWS_REGION}"

if [ "${1:-}" = "--list" ]; then
    echo "Available backups in s3://${S3_BACKUP_BUCKET}/postgres/:"
    aws s3 ls "s3://${S3_BACKUP_BUCKET}/postgres/" --recursive --human-readable
    exit 0
fi

S3_KEY="${1:-}"
if [ -z "$S3_KEY" ]; then
    echo "Usage: bash restore-db-s3.sh <s3-key>   (or --list)"
    exit 1
fi

PG_CONTAINER=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
[ -n "$PG_CONTAINER" ] || { echo "ERROR: no running postgres container"; exit 1; }

echo "This will restore ${S3_KEY} into database '${POSTGRES_DB}'"
echo "on container '${PG_CONTAINER}'. Existing data may be overwritten."
read -r -p "Type 'yes' to continue: " confirm
[ "$confirm" = "yes" ] || { echo "Aborted."; exit 1; }

TMP_FILE=$(mktemp /tmp/restore_XXXXXX.sql.gz)
trap 'rm -f "$TMP_FILE"' EXIT

echo "Downloading..."
aws s3 cp "s3://${S3_BACKUP_BUCKET}/${S3_KEY}" "$TMP_FILE" --only-show-errors

echo "Restoring..."
gunzip -c "$TMP_FILE" | docker exec -i "$PG_CONTAINER" psql -U "$POSTGRES_USER" -d "$POSTGRES_DB"

echo "Restore complete. Restart the backend to clear stale connections:"
echo "  docker compose restart backend"
