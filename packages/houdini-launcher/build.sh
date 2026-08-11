url=$(vinaya sidefx \
    download.get-daily-build-download \
    houdini-launcher \
    $PKG_VERSION \
    $minor \
    production \
    linux \
    | jq -r '.download_url')
aria2c -c -x16 -s16 "$url" -o install_houdini_launcher.sh
mkdir -p $PREFIX/bin
chmod +x install_houdini_launcher.sh
mv install_houdini_launcher.sh $PREFIX/bin/
