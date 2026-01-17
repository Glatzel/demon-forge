#!/bin/sh

# Save current directory
OLD_PWD="$PWD"

# Go to script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

gh release download -R "Loyalsoldier/v2ray-rules-dat" -p "geoip.dat" \
    -O  $PSScriptRoot/geoip.dat
gh release download -R "Loyalsoldier/v2ray-rules-dat" -p "geoip.dat" \
    -O  $PSScriptRoot/geosite.dat

# Restore original directory
cd "$OLD_PWD" || exit 1

echo "Back to: $(pwd)"
