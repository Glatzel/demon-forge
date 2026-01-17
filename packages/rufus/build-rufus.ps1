gh release download -R "pbatard/${env:PKG_NAME}" -p "${env:PKG_NAME}-*.??.exe" `
    -O  "$env:PREFIX/bin/${env:PKG_NAME}.exe"
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"
