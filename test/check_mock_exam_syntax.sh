#!/bin/bash
# Syntax-check the mock exam backend files.
cd "$(dirname "$0")/../backend-python" || exit 1
status=0
for f in routes/certificates.py services/mock_exam_service.py; do
    if python3 -m py_compile "$f" 2>/dev/null; then
        echo "OK   $f"
    else
        echo "FAIL $f"
        python3 -m py_compile "$f"
        status=1
    fi
done
exit $status
