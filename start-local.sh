#!/bin/bash
# Start Docker containers và fix WSL2 port forwarding
# Chạy: wsl -e bash -c "cd /mnt/c/source/dic && bash start-local.sh"

echo "=== Starting Docker containers ==="
docker-compose up -d

echo ""
echo "=== Waiting for services... ==="
sleep 5

echo ""
echo "=== Fixing Windows port forwarding ==="
WSL_IP=$(hostname -I | awk '{print $1}')
echo "WSL IP: $WSL_IP"

# Update port proxy (requires admin on Windows side)
# Run these commands in PowerShell as Admin if ports don't work:
echo ""
echo "If localhost:3000 doesn't work from Windows, run in PowerShell (Admin):"
echo "  netsh interface portproxy delete v4tov4 listenport=3000 listenaddress=0.0.0.0"
echo "  netsh interface portproxy delete v4tov4 listenport=4000 listenaddress=0.0.0.0"
echo "  netsh interface portproxy add v4tov4 listenport=3000 listenaddress=0.0.0.0 connectport=3000 connectaddress=$WSL_IP"
echo "  netsh interface portproxy add v4tov4 listenport=4000 listenaddress=0.0.0.0 connectport=4000 connectaddress=$WSL_IP"

echo ""
echo "=== Container status ==="
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "=== Access URLs ==="
echo "  From WSL:     http://localhost:3000"
echo "  From Windows: http://$WSL_IP:3000"
echo ""
