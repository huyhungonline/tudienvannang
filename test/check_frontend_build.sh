#!/bin/bash
# Type-check and build the frontend to verify changes compile.
cd "$(dirname "$0")/.." || exit 1

echo "=== Building shared package ==="
npm run build -w shared 2>&1 | tail -5

echo ""
echo "=== Building frontend ==="
npm run build -w frontend 2>&1 | tail -25
