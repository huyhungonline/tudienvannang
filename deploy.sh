#!/usr/bin/env bash
# Run from WSL. Commit only explicitly staged files; never git add the workspace.
# Usage: bash deploy.sh [commit message]
set -euo pipefail
cd "$(dirname "$0")"
VPS_HOST="${VPS_HOST:-14.225.198.235}"
VPS_USER="${VPS_USER:-root}"
VPS_DIR="${VPS_DIR:-/root/tudienvannang}"
COMMIT_MSG="${1:-Deploy structured IT Passport question bank}"
[[ "$(git branch --show-current)" == main ]] || { echo 'Deploy requires branch main'; exit 1; }
git diff --quiet || { echo 'Commit or stage the intended tracked changes before deploying'; exit 1; }
if ! git diff --cached --quiet; then git commit -m "$COMMIT_MSG"; fi
REVISION=$(git rev-parse HEAD)
echo "Deploy revision: $REVISION"
git push origin main
ssh -o BatchMode=yes -o ConnectTimeout=15 "${VPS_USER}@${VPS_HOST}" \
    "remote_script=\$(mktemp /tmp/itpp-deploy.XXXXXX); trap 'rm -f \"\$remote_script\"' EXIT; cat >\"\$remote_script\"; bash \"\$remote_script\" $(printf '%q' "$VPS_DIR") $(printf '%q' "$REVISION")" \
    < tool/deploy_itpp_remote.sh
