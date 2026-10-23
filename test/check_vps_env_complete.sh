#!/bin/bash
# Report keys present in .env.example but missing from the VPS .env.
# Names only; no values are printed.
cd "$(dirname "$0")/.." || exit 1

EXPECTED=$(grep -oP '^[A-Za-z_][A-Za-z0-9_]*(?==)' .env.example | sort -u)
REMOTE=$(ssh root@14.225.198.235 "grep -oP '^[A-Za-z_][A-Za-z0-9_]*(?==)' /root/tudienvannang/.env | sort -u")

echo "=== Missing on VPS (in .env.example but not on server) ==="
comm -23 <(echo "$EXPECTED") <(echo "$REMOTE") | sed 's/^/  - /' || true
comm -23 <(echo "$EXPECTED") <(echo "$REMOTE") | grep -q . || echo "  (none)"

echo ""
echo "=== Extra on VPS (on server but not in .env.example) ==="
comm -13 <(echo "$EXPECTED") <(echo "$REMOTE") | sed 's/^/  - /' || true
comm -13 <(echo "$EXPECTED") <(echo "$REMOTE") | grep -q . || echo "  (none)"
