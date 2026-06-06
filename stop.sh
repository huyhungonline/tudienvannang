#!/bin/bash

# English Word Splitter - Stop Script
echo "Stopping all services..."

pkill -f "uvicorn main:app" 2>/dev/null && echo "  Backend stopped." || echo "  Backend not running."
pkill -f "vite" 2>/dev/null && echo "  Frontend stopped." || echo "  Frontend not running."
fuser -k 3001/tcp 2>/dev/null || true
fuser -k 4000/tcp 2>/dev/null || true

echo "Done."
