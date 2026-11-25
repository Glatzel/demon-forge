#!/usr/bin/env bash
set -euo pipefail

mkdir -p "${PREFIX}/lib/dsh" "${PREFIX}/bin"
npm install \
    --prefix "${PREFIX}/lib/dsh" \
    --cache "./npm-cache" \
    --omit=dev \
    --no-audit \
    --no-fund \
    "@deepseek-ai/dsh@latest"

cat <<'EOF' > "${PREFIX}/bin/dsh"
#!/bin/sh
SELF_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
if [ -x "${SELF_DIR}/node" ]; then
    exec "${SELF_DIR}/node" "${SELF_DIR}/../lib/dsh/node_modules/@deepseek-ai/dsh/lib/bin.js" "$@"
else
    exec node "${SELF_DIR}/../lib/dsh/node_modules/@deepseek-ai/dsh/lib/bin.js" "$@"
fi
EOF
chmod +x "${PREFIX}/bin/dsh"
