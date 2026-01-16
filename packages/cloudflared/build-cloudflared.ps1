$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsWindows) {
    gh release download -R "cloudflare/${env:PKG_NAME}" -p "${env:PKG_NAME}-windows-amd64.exe" `
        -O  $env:PREFIX/bin/${env:PKG_NAME}.exe --clobber
}
if ($IsLinux -and ($arch -eq 'X64')) {
    gh release download -R "cloudflare/${env:PKG_NAME}" -p "${env:PKG_NAME}-linux-amd64" `
        -O  $env:PREFIX/bin/${env:PKG_NAME} --clobber
}
if ($IsLinux -and ($arch -eq 'Arm64')) {
    gh release download -R "cloudflare/${env:PKG_NAME}" -p "${env:PKG_NAME}-linux-arm64" `
        -O  $env:PREFIX/bin/${env:PKG_NAME} --clobber
}if ($IsLinux) {
    chmod +rwx "$env:PREFIX/bin/${env:PKG_NAME}"
}
