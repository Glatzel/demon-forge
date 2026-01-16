aria2c -c -x16 -s16 -d ./ `
    "https://googledownloads.cn/android/repository/platform-tools-latest-windows.zip" `
    -o "${env:PKG_NAME}.zip"
7z x "./${env:PKG_NAME}.zip" "-o./${env:PKG_NAME}"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./${env:PKG_NAME}/platform-tools/*" "$env:PREFIX/bin" -recurse
