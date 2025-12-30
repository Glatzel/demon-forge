Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($isWindows) {
    gh release download -R "microsoft/$name" -p "*x86_64-windows*" `
        -O  $ROOT/temp/$name/$name.zip --clobber
    7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name"
}
if ($IsLinux -and ($arch -eq 'X64')) {
    gh release download -R "microsoft/$name" -p "*x86_64-linux*" `
        -O  $ROOT/temp/$name/$name.tar.zst --clobber
    tar  --zstd -xvf "$ROOT/temp/$name/$name.tar.zst" -C "$ROOT/temp/$name"
    Remove-Item "$ROOT/temp/$name/$name.tar.zst"
}
if ($IsLinux -and ($arch -eq 'Arm64')) {
    gh release download -R "microsoft/$name" -p "*aarch64-linux*" `
        -O  $ROOT/temp/$name/$name.tar.zst --clobber
    tar  --zstd -xvf "$ROOT/temp/$name/$name.tar.zst" -C "$ROOT/temp/$name"
    Remove-Item "$ROOT/temp/$name/$name.tar.zst"
}
New-Item $env:PREFIX/bin -ItemType Directory
if ($IsWindows) {
    Copy-Item "$ROOT/temp/$name/*/$name.exe" "$env:PREFIX/bin/$name.exe"
}
if ($IsLinux) {
    Copy-Item "$ROOT/temp/$name/$name" "$env:PREFIX/bin/$name"
    chmod +rwx "$env:PREFIX/bin/$name"
}
