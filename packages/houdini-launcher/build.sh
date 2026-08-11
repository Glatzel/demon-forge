cd $PREFIX
url=$(vinaya sidefx \
    download.get-daily-build-download \
    houdini-launcher \
    $PKG_VERSION \
    production \
    linux \
    | jq -r '.download_url')
aria2c -c -x16 -s16 "$url" -o install_houdini_launcher.sh
chmod +x install_houdini_launcher.sh
./install_houdini_launcher.sh houdini_launcher
rm ./install_houdini_launcher.sh
