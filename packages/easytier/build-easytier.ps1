Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsWindows) {
    gh release download -R "EasyTier/EasyTier" -p "$name-windows-x86_64-*.zip" `
        -O  $ROOT/temp/$name/$name.zip --clobber
}
if ($IsLinux -and ($arch -eq "X64")) {
    gh release download -R "EasyTier/EasyTier" -p "$name-linux-x86_64-*.zip" `
        -O  $ROOT/temp/$name/$name.zip --clobber
}
if ($IsLinux -and ($arch -eq "Arm64")) {
    gh release download -R "EasyTier/EasyTier" -p "$name-linux-aarch64-*.zip" `
        -O  $ROOT/temp/$name/$name.zip --clobber
}
if ($IsMacOS) {
    gh release download -R "EasyTier/EasyTier" -p "$name-macos-aarch64-*.zip" `
        -O  $ROOT/temp/$name/$name.zip --clobber
}
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name/$name*/*" "$env:PREFIX/bin/" -Recurse
