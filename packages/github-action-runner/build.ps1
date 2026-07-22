gh release download -R "actions/runner" -p "*win-x64*" `
    -O "${env:PKG_NAME}.zip"
7z x "${env:PKG_NAME}.zip" "-o$env:PREFIX"
