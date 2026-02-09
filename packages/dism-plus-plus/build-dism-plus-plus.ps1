gh release download -R Chuyu-Team/Dism-Multi-language -p "Dism*.zip" `
    -O  "./${env:PKG_NAME}.zip"
7z x "${env:PKG_NAME}.zip"  "-o$env:PREFIX/bin"
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"
