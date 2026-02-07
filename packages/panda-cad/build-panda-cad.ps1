7z x "${env:PKG_NAME}.exe" "-o$env:PREFIX/bin/${env:PKG_NAME}"
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"
