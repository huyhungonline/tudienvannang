# Test local API from Windows PowerShell
# Usage: powershell -ExecutionPolicy Bypass -File test-local.ps1

$wslIp = (wsl -e hostname -I).Trim().Split(" ")[0]
Write-Host "WSL IP: $wslIp" -ForegroundColor Yellow
$base = "http://${wslIp}"

Write-Host "========== TEST LOCAL API ==========" -ForegroundColor Cyan

# Test frontend
Write-Host ""
Write-Host "--- Frontend (port 3000) ---"
try {
    $r = Invoke-WebRequest -Uri "${base}:3000/" -UseBasicParsing -TimeoutSec 5
    Write-Host "Frontend: OK ($($r.StatusCode))" -ForegroundColor Green
} catch {
    Write-Host "Frontend: FAIL" -ForegroundColor Red
}

# Test backend EN->JA
Write-Host ""
Write-Host "--- Backend EN to JA ---"
try {
    $body = '{"text":"hello world","targetLanguage":"ja","sourceLanguage":"en"}'
    $r = Invoke-WebRequest -Uri "${base}:4000/api/words/split" -Method POST -Body $body -ContentType "application/json" -UseBasicParsing -TimeoutSec 10
    Write-Host "Backend (EN->JA): OK ($($r.StatusCode))" -ForegroundColor Green
    $json = $r.Content | ConvertFrom-Json
    Write-Host "  Words: $($json.words.Count)"
} catch {
    Write-Host "Backend: FAIL" -ForegroundColor Red
}

# Test multilang JA->VI using unicode escape
Write-Host ""
Write-Host "--- Multilang JA to VI ---"
try {
    $jaText = [char]0x7D4C + [char]0x6E08 + [char]0x306F + [char]0x56DE + [char]0x5FA9
    $bodyObj = @{text=$jaText; targetLanguage="vi"; sourceLanguage="ja"} | ConvertTo-Json -Compress
    $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($bodyObj)
    $r = Invoke-WebRequest -Uri "${base}:4000/api/words/split" -Method POST -Body $bodyBytes -ContentType "application/json; charset=utf-8" -UseBasicParsing -TimeoutSec 15
    Write-Host "Multilang (JA->VI): OK ($($r.StatusCode))" -ForegroundColor Green
    $content = [System.Text.Encoding]::UTF8.GetString($r.Content)
    $json = $content | ConvertFrom-Json
    Write-Host "  Words: $($json.words.Count)"
    Write-Host "  Sentence: $($json.sentenceTranslation)"
} catch {
    Write-Host "Multilang: FAIL" -ForegroundColor Red
    Write-Host "  Error: $_" -ForegroundColor Red
}

# Test frontend proxy
Write-Host ""
Write-Host "--- Frontend Proxy ---"
try {
    $body = '{"text":"test","targetLanguage":"ja","sourceLanguage":"en"}'
    $r = Invoke-WebRequest -Uri "${base}:3000/api/words/split" -Method POST -Body $body -ContentType "application/json" -UseBasicParsing -TimeoutSec 10
    Write-Host "Proxy: OK ($($r.StatusCode))" -ForegroundColor Green
} catch {
    Write-Host "Proxy: FAIL" -ForegroundColor Red
}

Write-Host ""
Write-Host "========== DONE ==========" -ForegroundColor Cyan
