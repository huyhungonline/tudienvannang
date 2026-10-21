#!/bin/bash
# Sync only mail-related vars from server .env into local .env.
# Preserves all other local values (DB, JWT, reCAPTCHA) and local CRLF style.
set -e

SERVER_ENV="${1:-/tmp/env.server}"
LOCAL_ENV="${2:-.env}"
MAIL_KEYS="SMTP_HOST SMTP_PORT SMTP_USER SMTP_PASSWORD FROM_EMAIL FROM_NAME"

# Work on an LF copy to avoid CRLF artifacts
tr -d '\r' < "$LOCAL_ENV" > /tmp/env.work

for k in $MAIL_KEYS; do
    line=$(grep -m1 "^${k}=" "$SERVER_ENV" || true)
    if [ -z "$line" ]; then
        echo "skip  $k (not in server)"
        continue
    fi
    if grep -q "^${k}=" /tmp/env.work; then
        # Replace existing line; use a temp file to avoid sed delimiter issues
        grep -v "^${k}=" /tmp/env.work > /tmp/env.work2
        printf '%s\n' "$line" >> /tmp/env.work2
        mv /tmp/env.work2 /tmp/env.work
        echo "update $k"
    else
        printf '%s\n' "$line" >> /tmp/env.work
        echo "add   $k"
    fi
done

cp /tmp/env.work "$LOCAL_ENV"
echo ""
echo "Done. Local .env mail settings now match the server."
