IFS='.' read -r major minor <<EOF
$PKG_VERSION
EOF
url=$(vinaya sidefx \
    download.get-daily-build-download \
    --product houdini-launcher \
    --major $major \
    --minor $minor \
    --build production \
    --platform linux \
    | jq -r '.download_url')
aria2c -c -x16 -s16 "$url" -o install_houdini_launcher.sh
mkdir -p $PREFIX/houdini-launcher
chmod +x install_houdini_launcher.sh
mv install_houdini_launcher.sh $PREFIX/houdini-launcher/
