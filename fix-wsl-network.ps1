# Fix WSL2 networking - cho phep Windows truy cap localhost cua WSL
# Chay PowerShell as Admin

Write-Host "=== Fixing WSL2 port forwarding ===" -ForegroundColor Cyan

# Get WSL IP
$wslIp = (wsl -e hostname -I).Trim().Split(" ")[0]
Write-Host "WSL IP: $wslIp"

# Remove old proxies
netsh interface portproxy delete v4tov4 listenport=3000 listenaddress=0.0.0.0 2>$null
netsh interface portproxy delete v4tov4 listenport=4000 listenaddress=0.0.0.0 2>$null

# Add new proxies
netsh interface portproxy add v4tov4 listenport=3000 listenaddress=0.0.0.0 connectport=3000 connectaddress=$wslIp
netsh interface portproxy add v4tov4 listenport=4000 listenaddress=0.0.0.0 connectport=4000 connectaddress=$wslIp

# Allow firewall
netsh advfirewall firewall delete rule name="WSL2 Port 3000" 2>$null
netsh advfirewall firewall delete rule name="WSL2 Port 4000" 2>$null
netsh advfirewall firewall add rule name="WSL2 Port 3000" dir=in action=allow protocol=TCP localport=3000
netsh advfirewall firewall add rule name="WSL2 Port 4000" dir=in action=allow protocol=TCP localport=4000

Write-Host ""
Write-Host "=== Done! ===" -ForegroundColor Green
Write-Host "Current port proxies:"
netsh interface portproxy show v4tov4

Write-Host ""
Write-Host "Try: http://localhost:3000" -ForegroundColor Yellow
