aria2c -c -x16 -s16 -d ./ `
    "https://download.librepcb.org/releases/${env:PKG_VERSION}/librepcb-${env:PKG_VERSION}-windows-x86_64.zip" `
    -o "${env:PKG_NAME}.zip"
7z x "./${env:PKG_NAME}.zip" "-o./${env:PKG_NAME}"
New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}/*" "$env:PREFIX/bin/${env:PKG_NAME}" -Recurse
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:PKG_NAME}.json" "$env:PREFIX/Menu"
