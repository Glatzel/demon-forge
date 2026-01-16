gh release download -R "jqlang/${env:PKG_NAME}" -p "${env:PKG_NAME}-windows-amd64.exe" `
    -O  ./${env:PKG_NAME}.exe --clobber
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}.exe" "$env:PREFIX/bin/${env:PKG_NAME}.exe"
