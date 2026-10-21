#!/bin/bash
# Compare .env key sets between local and server (names only, no values printed)
LOCAL="${1:-.env}"
SERVER="${2:-/tmp/env.server}"

keys() { grep -oP '^[A-Za-z_][A-Za-z0-9_]*(?==)' "$1" | sort -u; }

echo "=== keys only in LOCAL ==="
comm -23 <(keys "$LOCAL") <(keys "$SERVER")

echo ""
echo "=== keys only in SERVER ==="
comm -13 <(keys "$LOCAL") <(keys "$SERVER")

echo ""
echo "=== keys present in both but VALUES differ ==="
for k in $(comm -12 <(keys "$LOCAL") <(keys "$SERVER")); do
    a=$(grep -m1 "^${k}=" "$LOCAL" | cut -d= -f2-)
    b=$(grep -m1 "^${k}=" "$SERVER" | cut -d= -f2-)
    if [ "$a" != "$b" ]; then
        echo "$k"
    fi
done
