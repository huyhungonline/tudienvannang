#!/usr/bin/env bash
# Invoked through SSH by deploy.sh. Never replay destructive seed migrations.
set -euo pipefail
VPS_DIR="${1:?repository directory required}"
REVISION="${2:?revision required}"
[[ "$REVISION" =~ ^[0-9a-f]{40}$ ]] || exit 1
cd "$VPS_DIR"
test -f .env
mkdir -p backups/deploy
exec 9>backups/deploy/.lock
flock -n 9 || { echo 'Another deployment is running'; exit 1; }
compose() {
    if docker compose version >/dev/null 2>&1; then docker compose "$@"; else docker-compose "$@"; fi
}
OLD_REVISION=$(git rev-parse HEAD)
BACKUP_DIR="$PWD/backups/deploy/$(date -u +%Y%m%dT%H%M%SZ)-${OLD_REVISION:0:8}"
mkdir -m 700 "$BACKUP_DIR"
ENV_DIGEST=$(sha256sum .env | cut -d' ' -f1)
printf '%s\n' "$OLD_REVISION" > "$BACKUP_DIR/revision.txt"
git diff --binary > "$BACKUP_DIR/local-edits.patch"
git status --porcelain > "$BACKUP_DIR/git-status.txt"
PG_CONTAINER=$(compose ps -q postgres)
test -n "$PG_CONTAINER"
BACKEND_CONTAINER=$(compose ps -q backend)
if [[ -n "$BACKEND_CONTAINER" ]]; then
    docker inspect --format '{{.Image}}' "$BACKEND_CONTAINER" > "$BACKUP_DIR/backend-image.txt"
fi
trap 'echo "Deployment failed at line $LINENO. Backup: $BACKUP_DIR. Database is not automatically restored." >&2' ERR
echo "=== Backup PostgreSQL: $BACKUP_DIR/database.dump ==="
docker exec "$PG_CONTAINER" sh -c \
    'exec pg_dump -U "${POSTGRES_USER:-postgres}" -d "${POSTGRES_DB:-english_word_splitter}" -Fc' \
    > "$BACKUP_DIR/database.dump"
chmod 600 "$BACKUP_DIR/database.dump"
test -s "$BACKUP_DIR/database.dump"
docker exec -i "$PG_CONTAINER" pg_restore --list < "$BACKUP_DIR/database.dump" > "$BACKUP_DIR/database-manifest.txt"
sha256sum "$BACKUP_DIR/database.dump" > "$BACKUP_DIR/database.sha256"
echo '=== Fast-forward source, preserving local changes ==='
git fetch origin main
git merge --ff-only origin/main
[[ "$(git rev-parse HEAD)" == "$REVISION" ]]
[[ "$(sha256sum .env | cut -d' ' -f1)" == "$ENV_DIGEST" ]]
compose config --quiet
# Compare settings only in subprocess memory; never log credentials.
python3 - "$BACKEND_CONTAINER" <<'PY'
import json, subprocess, sys
if sys.argv[1]:
    try:
        command=['docker','compose']
        subprocess.run(command+['version'],check=True,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
    except subprocess.CalledProcessError:
        command=['docker-compose']
    configured=json.loads(subprocess.check_output(command+['config','--format','json'],text=True))['services']['backend']['environment']
    current=dict(item.split('=',1) for item in json.loads(subprocess.check_output(
        ['docker','inspect','--format','{{json .Config.Env}}',sys.argv[1]],text=True)) if '=' in item)
    for key in ('DATABASE_URL','JWT_SECRET'):
        if configured.get(key) != current.get(key):
            raise SystemExit(f'Refusing deployment: {key} differs from the running backend; .env was not changed')
print('Backend database/session settings verified (values hidden)')
PY
echo '=== Build images while existing services continue running ==='
compose build backend frontend
echo '=== Validate JSON, migrate and import before replacing application containers ==='
compose run --rm --no-deps -T -v "$PWD:/workspace" backend \
    python /workspace/tool/import_itpp_questions.py --dry-run
compose run --rm --no-deps -T -v "$PWD:/workspace" backend \
    python /workspace/tool/import_itpp_questions.py --bootstrap-base --apply-migration
echo '=== Update backend/frontend; retain PostgreSQL container ==='
compose up -d --no-deps backend frontend
ready=false
for attempt in $(seq 1 30); do
    if compose exec -T backend python -c \
        "import urllib.request; urllib.request.urlopen('http://localhost:4000/api/health',timeout=3)" >/dev/null 2>&1; then
        ready=true
        break
    fi
    echo "Waiting for backend: $attempt/30"
    sleep 3
done
[[ "$ready" == true ]]
echo '=== Verify production data, stateless grading and live PDF/API ==='
compose run --rm --no-deps -T -v "$PWD:/workspace" \
    -e ITPP_API_URL=http://backend:4000 -e ITPP_FRONTEND_URL=http://frontend \
    backend python /workspace/tool/verify_itpp_database.py
[[ "$(sha256sum .env | cut -d' ' -f1)" == "$ENV_DIGEST" ]]
[[ "$(compose ps -q postgres)" == "$PG_CONTAINER" ]]
compose ps
printf 'DEPLOY_OK revision=%s backup=%s\n' "$REVISION" "$BACKUP_DIR"
