gh release download -R ${env:PKG_NAME}/${env:PKG_NAME} -p "${env:PKG_NAME}-*-win-64bit*.zip" `
    -O  ./${env:PKG_NAME}.zip
7z x "${env:PKG_NAME}.zip" "-o./${env:PKG_NAME}"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./${env:PKG_NAME}/*/aria2c.exe" "$env:PREFIX/bin/aria2c.exe"
