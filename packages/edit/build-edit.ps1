$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

if ($isWindows) {
    gh release download -R "microsoft/$name" -p "*x86_64-windows*" `
        -O  ./$name.zip --clobber
    7z x "./$name.zip" "-o./$name"
}
if ($IsLinux -and ($arch -eq 'X64')) {
    gh release download -R "microsoft/$name" -p "*x86_64-linux*" `
        -O  ./$name.tar.zst --clobber
    tar  --zstd -xvf "./$name.tar.zst" -C "."
    Remove-Item "./$name.tar.zst"
}
if ($IsLinux -and ($arch -eq 'Arm64')) {
    gh release download -R "microsoft/$name" -p "*aarch64-linux*" `
        -O  ./$name.tar.zst --clobber
    tar  --zstd -xvf "./$name.tar.zst" -C "."
    Remove-Item "./$name.tar.zst"
}
New-Item $env:PREFIX/bin -ItemType Directory
if ($IsWindows) {
    Copy-Item "./$name/*/$name.exe" "$env:PREFIX/bin/$name.exe"
}
if ($IsLinux) {
    Copy-Item "./$name/$name" "$env:PREFIX/bin/$name"
    chmod +rwx "$env:PREFIX/bin/$name"
}
