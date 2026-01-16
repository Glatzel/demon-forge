

aria2c -c -x16 -s16 -d ./ `
    "https://dist.${env:PKG_NAME}.org/win-x86-commandline/latest/${env:PKG_NAME}.exe" `
    -o "${env:PKG_NAME}.exe"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}.exe" "$env:PREFIX/bin/${env:PKG_NAME}.exe"
