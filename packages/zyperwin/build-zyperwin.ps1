gh release download -R ZyperWave/ZyperWinOptimize -p "ZyperWin*.zip" `
    -O  ./${env:PKG_NAME}.zip --clobber
7z x "./${env:PKG_NAME}.zip" "-o./${env:PKG_NAME}"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}/Release/*" "$env:PREFIX/bin" -Recurse# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"
