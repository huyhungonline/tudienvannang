#!/bin/bash
# Daily PostgreSQL backup to AWS S3.
# Runs on the VPS via cron. Dumps from the postgres container, gzips,
# uploads to S3, and keeps the last RETAIN_LOCAL_DAYS days of dumps on disk
# as a local fallback (older local copies are pruned each run).
#
# Required vars in .env:
#   POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_DB
#   AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_REGION, S3_BACKUP_BUCKET
#
# Usage: bash backup-db-s3.sh

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${PROJECT_DIR}/backups"
LOG_FILE="${PROJECT_DIR}/backups/backup.log"
RETAIN_LOCAL_DAYS=1

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

fail() {
    log "ERROR: $*"
    exit 1
}

mkdir -p "$BACKUP_DIR"

# --- Load env ---
[ -f "${PROJECT_DIR}/.env" ] || fail ".env not found at ${PROJECT_DIR}/.env"
set -a
# shellcheck disable=SC1091
. "${PROJECT_DIR}/.env"
set +a

: "${POSTGRES_USER:=postgres}"
: "${POSTGRES_DB:=english_word_splitter}"

for v in AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION S3_BACKUP_BUCKET; do
    if [ -z "${!v:-}" ]; then
        fail "$v is not set in .env"
    fi
done

export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION="$AWS_REGION"

command -v aws >/dev/null 2>&1 || fail "aws CLI not installed (run: apt-get install -y awscli)"

# --- Locate the running postgres container ---
PG_CONTAINER=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
[ -n "$PG_CONTAINER" ] || fail "no running postgres container found"

STAMP=$(date '+%Y%m%d_%H%M%S')
FILENAME="${POSTGRES_DB}_${STAMP}.sql.gz"
LOCAL_PATH="${BACKUP_DIR}/${FILENAME}"
S3_KEY="postgres/$(date '+%Y/%m')/${FILENAME}"

log "Starting backup from container ${PG_CONTAINER}"

# --- Dump + compress ---
# pg_dump writes to stdout; a failure anywhere in the pipe aborts via pipefail.
if ! docker exec "$PG_CONTAINER" pg_dump -U "$POSTGRES_USER" -d "$POSTGRES_DB" \
        | gzip -9 > "$LOCAL_PATH"; then
    rm -f "$LOCAL_PATH"
    fail "pg_dump failed"
fi

SIZE=$(du -h "$LOCAL_PATH" | cut -f1)
# Guard against a silently empty dump being treated as a good backup.
MIN_BYTES=1024
ACTUAL_BYTES=$(stat -c%s "$LOCAL_PATH")
if [ "$ACTUAL_BYTES" -lt "$MIN_BYTES" ]; then
    rm -f "$LOCAL_PATH"
    fail "dump suspiciously small (${ACTUAL_BYTES} bytes), aborting"
fi
log "Dump created: ${FILENAME} (${SIZE})"

# --- Upload ---
if aws s3 cp "$LOCAL_PATH" "s3://${S3_BACKUP_BUCKET}/${S3_KEY}" --only-show-errors; then
    log "Uploaded to s3://${S3_BACKUP_BUCKET}/${S3_KEY}"
else
    log "Upload failed; keeping local copy at ${LOCAL_PATH}"
    exit 1
fi

# --- Prune old local copies (S3 lifecycle handles remote retention) ---
find "$BACKUP_DIR" -name "${POSTGRES_DB}_*.sql.gz" -mtime "+${RETAIN_LOCAL_DAYS}" -delete
log "Backup complete"
