gh release download -R ${env:PKG_NAME}/${env:PKG_NAME} -p "${env:PKG_NAME}-win-*-64bit.zip" `
    -O  ./${env:PKG_NAME}.zip --clobber
7z x "./${env:PKG_NAME}.zip" "-o./${env:PKG_NAME}"
New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}/${env:PKG_NAME}*/*" "$env:PREFIX/bin/${env:PKG_NAME}" -Recurse# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:PKG_NAME}.json" "$env:PREFIX/Menu"
