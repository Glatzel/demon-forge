$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsWindows) {
    gh release download -R "cloudflare/${env:PKG_NAME}" -p "${env:PKG_NAME}-windows-amd64.exe" `
        -O  $env:PREFIX/bin/${env:PKG_NAME}.exe
}
if ($env:TARGET_PLATFORM -eq 'linux-64') {
    gh release download -R "cloudflare/${env:PKG_NAME}" -p "${env:PKG_NAME}-linux-amd64" `
        -O  $env:PREFIX/bin/${env:PKG_NAME}
}
if ($env:TARGET_PLATFORM -eq 'linux-aarch64') {
    gh release download -R "cloudflare/${env:PKG_NAME}" -p "${env:PKG_NAME}-linux-arm64" `
        -O  $env:PREFIX/bin/${env:PKG_NAME}
}
if ($IsLinux) {
    chmod +rwx "$env:PREFIX/bin/${env:PKG_NAME}"
}
