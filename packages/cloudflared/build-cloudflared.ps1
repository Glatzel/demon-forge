$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/bin -ItemType Directory
if ($IsWindows) {
    gh release download -R "cloudflare/$name" -p "$name-windows-amd64.exe" `
        -O  $env:PREFIX/bin/$name.exe --clobber
}
if ($IsLinux -and ($arch -eq 'X64')) {
    gh release download -R "cloudflare/$name" -p "$name-linux-amd64" `
        -O  $env:PREFIX/bin/$name --clobber
}
if ($IsLinux -and ($arch -eq 'Arm64')) {
    gh release download -R "cloudflare/$name" -p "$name-linux-arm64" `
        -O  $env:PREFIX/bin/$name --clobber
}

if ($IsLinux) {
    chmod +rwx "$env:PREFIX/bin/$name"
}
