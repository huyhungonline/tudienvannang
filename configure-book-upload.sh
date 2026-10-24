#!/usr/bin/env bash
# Apply the API upload envelope to this project's host Nginx sites.
set -euo pipefail
python3 - <<'PY'
from pathlib import Path
from datetime import datetime
import re
import subprocess

changed = []
for name in ('taogiaoduc', 'jaenglish'):
    path = Path('/etc/nginx/sites-available') / name
    if not path.is_file():
        continue
    original = path.read_text()
    # Each server block has its own server_name; keep the limit scoped here.
    updated = re.sub(r'^\s*client_max_body_size\s+[^;]+;[^\n]*\n', '', original, flags=re.M)
    updated = re.sub(r'(^[ \t]*server_name[^;]+;)', r'\1\n    client_max_body_size 10m;', updated, flags=re.M)
    if updated == original:
        continue
    backup = path.with_name(path.name + '.upload-backup-' + datetime.now().strftime('%Y%m%d-%H%M%S'))
    backup.write_text(original)
    changed.append((path, original))
    path.write_text(updated)
if changed:
    try:
        subprocess.run(['nginx', '-t'], check=True)
        subprocess.run(['systemctl', 'reload', 'nginx'], check=True)
    except Exception:
        for path, original in changed:
            path.write_text(original)
        raise
print('Host Nginx upload limit: 10 MB; changed sites:', len(changed))
PY
