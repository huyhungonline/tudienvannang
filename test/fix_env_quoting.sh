#!/bin/bash
# Quote .env values that contain spaces so the file is safe to `source`.
cd "$(dirname "$0")/.." || exit 1

TARGET="${1:-.env}"
tr -d '\r' < "$TARGET" > /tmp/env.q

: > /tmp/env.q2
while IFS= read -r line || [ -n "$line" ]; do
    # Pass through blanks, comments, and anything not KEY=VALUE
    if [[ ! "$line" =~ ^[A-Za-z_][A-Za-z0-9_]*= ]]; then
        printf '%s\n' "$line" >> /tmp/env.q2
        continue
    fi
    key="${line%%=*}"
    val="${line#*=}"
    # Quote only if it has whitespace and is not already quoted
    if [[ "$val" == *" "* ]] && [[ ! "$val" =~ ^\".*\"$ ]] && [[ ! "$val" =~ ^\'.*\'$ ]]; then
        printf '%s="%s"\n' "$key" "$val" >> /tmp/env.q2
        echo "quoted: $key"
    else
        printf '%s\n' "$line" >> /tmp/env.q2
    fi
done < /tmp/env.q

mv /tmp/env.q2 "$TARGET"
rm -f /tmp/env.q
echo "Done."
