

if ($IsWindows) {
    gh release download -R "EasyTier/EasyTier" -p "${env:PKG_NAME}-windows-x86_64-*.zip" `
        -O  ./${env:PKG_NAME}.zip --clobber
}
if ($IsLinux -and ($arch -eq "X64")) {
    gh release download -R "EasyTier/EasyTier" -p "${env:PKG_NAME}-linux-x86_64-*.zip" `
        -O  ./${env:PKG_NAME}.zip --clobber
}
if ($IsLinux -and ($arch -eq "Arm64")) {
    gh release download -R "EasyTier/EasyTier" -p "${env:PKG_NAME}-linux-aarch64-*.zip" `
        -O  ./${env:PKG_NAME}.zip --clobber
}
if ($IsMacOS) {
    gh release download -R "EasyTier/EasyTier" -p "${env:PKG_NAME}-macos-aarch64-*.zip" `
        -O  ./${env:PKG_NAME}.zip --clobber
}
7z x "./${env:PKG_NAME}.zip" "-o./${env:PKG_NAME}"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}/${env:PKG_NAME}*/*" "$env:PREFIX/bin/" -Recurse
