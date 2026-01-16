

if ($isWindows) {
    gh release download -R "microsoft/${env:PKG_NAME}" -p "*x86_64-windows*" `
        -O  ./${env:PKG_NAME}.zip --clobber
    7z x "./${env:PKG_NAME}.zip" "-o./${env:PKG_NAME}"
}
if ($IsLinux -and ($arch -eq 'X64')) {
    gh release download -R "microsoft/${env:PKG_NAME}" -p "*x86_64-linux*" `
        -O  ./${env:PKG_NAME}.tar.zst --clobber
    tar  --zstd -xvf "./${env:PKG_NAME}.tar.zst" -C "."
    Remove-Item "./${env:PKG_NAME}.tar.zst"
}
if ($IsLinux -and ($arch -eq 'Arm64')) {
    gh release download -R "microsoft/${env:PKG_NAME}" -p "*aarch64-linux*" `
        -O  ./${env:PKG_NAME}.tar.zst --clobber
    tar  --zstd -xvf "./${env:PKG_NAME}.tar.zst" -C "."
    Remove-Item "./${env:PKG_NAME}.tar.zst"
}
New-Item $env:PREFIX/bin -ItemType Directory
if ($IsWindows) {
    Copy-Item "./${env:PKG_NAME}/*/${env:PKG_NAME}.exe" "$env:PREFIX/bin/${env:PKG_NAME}.exe"
}
if ($IsLinux) {
    Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}" "$env:PREFIX/bin/${env:PKG_NAME}"
    chmod +rwx "$env:PREFIX/bin/${env:PKG_NAME}"
}
