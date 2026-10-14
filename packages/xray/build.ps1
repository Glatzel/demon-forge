$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
gh release download -R "XTLS/Xray-core" -p "Xray-windows-64.zip" `
    -O  ./${env:PKG_NAME}.zip
7z x "${env:PKG_NAME}.zip" "-o$env:PREFIX/bin/${env:PKG_NAME}"
Copy-Item $env:RECIPE_DIR/update-geofile.ps1 $env:PREFIX/bin/${env:PKG_NAME}/
