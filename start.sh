#!/bin/bash

# English Word Splitter - Start Script
# Chạy: chmod +x start.sh && ./start.sh

set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$PROJECT_DIR"

# Kill any existing processes on our ports
echo "Cleaning up old processes..."
pkill -f "uvicorn main:app" 2>/dev/null || true
fuser -k 3001/tcp 2>/dev/null || true
fuser -k 4000/tcp 2>/dev/null || true
sleep 1

echo "=== English Word Splitter ==="
echo ""

# 1. Start PostgreSQL via Docker
echo "[1/4] Starting PostgreSQL..."
if docker ps --format '{{.Names}}' | grep -q 'postgres-dic'; then
  echo "  PostgreSQL already running."
else
  docker rm -f postgres-dic 2>/dev/null || true
  docker run -d --name postgres-dic \
    -p 5432:5432 \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_PASSWORD=postgres \
    -e POSTGRES_DB=english_word_splitter \
    -v postgres-dic-data:/var/lib/postgresql/data \
    postgres:16-alpine > /dev/null
  echo "  PostgreSQL started on port 5432."
  sleep 3
fi

# 2. Setup Python backend
echo "[2/4] Setting up Python backend..."
cd "$PROJECT_DIR/backend-python"
if [ ! -d "venv" ]; then
  python3 -m venv venv
fi
source venv/bin/activate
pip install -r requirements.txt -q 2>/dev/null

# Run migrations
python3 -c "
import asyncio, asyncpg

async def migrate():
    conn = await asyncpg.connect('postgresql://postgres:postgres@localhost:5432/english_word_splitter')
    with open('migrations/001_initial_schema.sql', 'r') as f:
        sql = f.read()
    await conn.execute(sql)
    await conn.close()

asyncio.run(migrate())
" 2>/dev/null || true
echo "  Backend ready."

# 3. Start Backend
echo "[3/4] Starting Backend on port 4000..."
cd "$PROJECT_DIR/backend-python"
source venv/bin/activate
uvicorn main:app --host 0.0.0.0 --port 4000 &
BACKEND_PID=$!
sleep 2
echo "  Backend running (PID: $BACKEND_PID)."

# 4. Start Frontend
echo "[4/4] Starting Frontend on port 3001..."
cd "$PROJECT_DIR/frontend"
npx vite --host 0.0.0.0 --port 3001 &
FRONTEND_PID=$!
sleep 3
echo "  Frontend running (PID: $FRONTEND_PID)."

echo ""
echo "=== App is ready! ==="
echo "  Frontend: http://localhost:3001"
echo "  Backend:  http://localhost:4000"
echo ""
echo "Press Ctrl+C to stop all services."

trap "kill $BACKEND_PID $FRONTEND_PID 2>/dev/null; echo 'Stopped.'" EXIT
wait
