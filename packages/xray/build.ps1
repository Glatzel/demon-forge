gh release download -R "XTLS/Xray-core" -p "Xray-windows-64.zip" `
    -O  ./${env:PKG_NAME}.zip
7z x "${env:PKG_NAME}.zip" "-o$env:PREFIX/bin"
