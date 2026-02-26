New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./${env:PKG_NAME}.exe" "$env:PREFIX/bin/${env:PKG_NAME}.exe"
