New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
if ($IsWindows) {
    gh release download -R 2dust/v2rayN -p "v2rayN-windows-64-desktop.zip" `
        -O  ./${env:PKG_NAME}.zip
}
# if ($IsMacOS) {
#     gh release download -R 2dust/v2rayN -p "v2rayN-macos-arm64.zip" `
#         -O  ./${env:PKG_NAME}.zip
# }
# if ($env:TARGET_PLATFORM -eq 'linux-64') {
#     gh release download -R 2dust/v2rayN -p "v2rayN-linux-64.zip" `
#         -O  ./${env:PKG_NAME}.zip
# }
# if ($env:TARGET_PLATFORM -eq 'linux-aarch64') {
#     gh release download -R 2dust/v2rayN -p "v2rayN-linux-arm64.zip" `
#         -O  ./${env:PKG_NAME}.zip# }
7z x "${env:PKG_NAME}.zip" "-o$env:PREFIX/bin/${env:PKG_NAME}"
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"
