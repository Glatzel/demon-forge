aria2c --max-tries=5 --retry-wait=10 -c -x16 -s16 -d "./" `
    "https://nssm.cc/release/nssm-${env:PKG_VERSION}.zip" `
    -o "${env:PKG_NAME}.zip"7z x "./${env:PKG_NAME}.zip" "-o./${env:PKG_NAME}"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}/${env:PKG_NAME}*/Win64/${env:PKG_NAME}.exe" "$env:PREFIX/bin/${env:PKG_NAME}.exe"
