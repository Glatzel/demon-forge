if ($IsWindows) {
    gh release download -R "XTLS/Xray-core" -p "Xray-windows-64.zip" `
        -O  ./${env:PKG_NAME}.zip --clobber
}
if ($IsLinux -and ($arch -eq "X64")) {
    gh release download -R "XTLS/Xray-core" -p "Xray-linux-64.zip" `
        -O  ./${env:PKG_NAME}.zip --clobber
}
if ($IsLinux -and ($arch -eq "Arm64")) {
    gh release download -R "XTLS/Xray-core" -p "Xray-linux-arm64-v8a.zip" `
        -O  ./${env:PKG_NAME}.zip --clobber
}
if ($IsMacOS) {
    gh release download -R "XTLS/Xray-core" -p "Xray-macos-arm64-v8a.zip" `
        -O  ./${env:PKG_NAME}.zip --clobber
}
7z x "${env:PKG_NAME}.zip" "-o$env:PREFIX/bin/${env:PKG_NAME}"
if ($IsWindows) {
    Copy-Item $env:RECIPE_DIR/update-geofile.ps1 $env:PREFIX/bin/${env:PKG_NAME}/
}
else {
    Copy-Item $env:RECIPE_DIR/update-geofile.sh $env:PREFIX/bin/${env:PKG_NAME}/
}
if ($IsLinux) {
    chmod +rwx "$env:PREFIX/bin/${env:PKG_NAME}/${env:PKG_NAME}"
}
