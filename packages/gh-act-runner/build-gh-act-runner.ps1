$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsWindows) {
    gh release download -R "ChristopherHX/github-act-runner" -p "binary-windows-amd64.zip" `
        -O "${env:PKG_NAME}.zip"
}
if ($IsMacos) {
    gh release download -R "ChristopherHX/github-act-runner" -p "binary-darwin-arm64.tar.gz" `
        -O "${env:PKG_NAME}.tar.gz"
}
if ($env:TARGET_PLATFORM -eq 'linux-64') {
    gh release download -R "ChristopherHX/github-act-runner" -p "binary-linux-amd64.tar.gz" `
        -O "${env:PKG_NAME}.tar.gz"
}
if ($env:TARGET_PLATFORM -eq 'linux-aarch64') {
    gh release download -R "ChristopherHX/github-act-runner" -p "binary-linux-arm64.tar.gz" `
        -O "${env:PKG_NAME}.tar.gz"
}
if ($IsWindows) {
7z x "${env:PKG_NAME}.zip" "-o$env:PREFIX/bin"
}
else{
7z x "${env:PKG_NAME}.tar.gz"
7z x "${env:PKG_NAME}.tar" "-o$env:PREFIX/bin"
}
foreach($f in Get-ChildItem $env:PREFIX/bin/github-act-runner*){
    Rename-Item $f "$f".Replace("github","gh")
}
