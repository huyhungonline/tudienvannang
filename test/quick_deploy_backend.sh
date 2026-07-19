#!/bin/bash
# Push code and rebuild only backend on server
cd /mnt/c/source/dic
git add -A && git commit -m "improve email debug logging" && git push

ssh root@14.225.198.235 << 'EOF'
cd /root/tudienvannang
git pull
docker-compose up -d --build backend
sleep 5
docker logs tudienvannang_backend_1 --tail 3
EOF
