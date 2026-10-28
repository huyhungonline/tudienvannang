#!/bin/bash
# Syntax-check the MCP and book customer backend files.
cd "$(dirname "$0")/../backend-python" || exit 1
status=0
for f in main.py config.py routes/mcp.py routes/book_customers.py services/book_customer_service.py; do
    if python3 -m py_compile "$f" 2>/dev/null; then
        echo "OK   $f"
    else
        echo "FAIL $f"
        python3 -m py_compile "$f"
        status=1
    fi
done
exit $status
