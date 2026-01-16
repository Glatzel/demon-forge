


New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
if ($IsWindows) {
    gh release download -R 2dust/v2rayN -p "v2rayN-windows-64-SelfContained.zip" `
        -O  ./${env:PKG_NAME}.zip --clobber
}
# if ($IsMacOS) {
#     gh release download -R 2dust/v2rayN -p "v2rayN-macos-arm64.zip" `
#         -O  ./${env:PKG_NAME}.zip --clobber
# }
# if ($IsLinux -and $arch -eq "X64") {
#     gh release download -R 2dust/v2rayN -p "v2rayN-linux-64.zip" `
#         -O  ./${env:PKG_NAME}.zip --clobber
# }
# if ($IsLinux -and $arch -eq "Arm64") {
#     gh release download -R 2dust/v2rayN -p "v2rayN-linux-arm64.zip" `
#         -O  ./${env:PKG_NAME}.zip --clobber

# }
7z x "./${env:PKG_NAME}.zip" "-o./${env:PKG_NAME}"
if ($IsWindows) {
    Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}/v2rayN-windows-64-SelfContained/*" "$env:PREFIX/bin/${env:PKG_NAME}/" -Recurse
}
# if ($IsMacOS) {
#     Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}/v2rayN-macos-arm64/*" "$env:PREFIX/bin/${env:PKG_NAME}/" -Recurse
# }
# if ($IsLinux -and $arch -eq "X64") {
#     Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}/v2rayN-linux-64/*" "$env:PREFIX/bin/${env:PKG_NAME}/" -Recurse
# }
# if ($IsLinux -and $arch -eq "Arm64") {
#     Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}/v2rayN-linux-arm64/*" "$env:PREFIX/bin/${env:PKG_NAME}/" -Recurse
# }
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:PKG_NAME}.json" "$env:PREFIX/Menu"
