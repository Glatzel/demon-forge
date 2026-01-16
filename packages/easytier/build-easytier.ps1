$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

if ($IsWindows) {
    gh release download -R "EasyTier/EasyTier" -p "$name-windows-x86_64-*.zip" `
        -O  ./$name.zip --clobber
}
if ($IsLinux -and ($arch -eq "X64")) {
    gh release download -R "EasyTier/EasyTier" -p "$name-linux-x86_64-*.zip" `
        -O  ./$name.zip --clobber
}
if ($IsLinux -and ($arch -eq "Arm64")) {
    gh release download -R "EasyTier/EasyTier" -p "$name-linux-aarch64-*.zip" `
        -O  ./$name.zip --clobber
}
if ($IsMacOS) {
    gh release download -R "EasyTier/EasyTier" -p "$name-macos-aarch64-*.zip" `
        -O  ./$name.zip --clobber
}
7z x "./$name.zip" "-o./$name"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./$name/$name/$name*/*" "$env:PREFIX/bin/" -Recurse
