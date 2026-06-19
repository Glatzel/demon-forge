gh release download -R "cloudflare/${env:PKG_NAME}" -p "${env:PKG_NAME}-windows-amd64.exe" `
    -O  $env:PREFIX/bin/${env:PKG_NAME}.exe
