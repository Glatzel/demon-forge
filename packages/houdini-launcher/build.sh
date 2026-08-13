IFS='.' read -r major minor patch <<EOF
$PKG_VERSION
EOF
url=$(vinaya sidefx \
    download.get-daily-build-download \
    houdini-launcher \
    "$major.$minor" \
    production \
    $TARGET_PLATFORM \
    | jq -r '.download_url')
aria2c -c -x16 -s16 "$url" -o install_houdini_launcher.sh
mkdir -p $PREFIX/bin
chmod +x install_houdini_launcher.sh
mv install_houdini_launcher.sh $PREFIX/bin/
