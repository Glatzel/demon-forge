$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsWindows) {
    gh release download -R "actions/runner" -p "*win-x64*" `
        -O "${env:PKG_NAME}.zip"
}
if ($IsMacos) {
    gh release download -R "actions/runner" -p "*osx-arm64*" `
        -O "${env:PKG_NAME}.tar.gz"
}
if ($env:TARGET_PLATFORM -eq 'linux-64') {
    gh release download -R "actions/runner" -p "*linux-x64*" `
        -O "${env:PKG_NAME}.tar.gz"
}
if ($env:TARGET_PLATFORM -eq 'linux-aarch64') {
    gh release download -R "actions/runner" -p "*linux-arm64*" `
        -O "${env:PKG_NAME}.tar.gz"
}
if ($IsWindows) {
7z x "${env:PKG_NAME}.zip" "-o$env:PREFIX"
}
else{
7z x "${env:PKG_NAME}.tar.gz"
7z x "${env:PKG_NAME}.tar" "-o$env:PREFIX"
}
