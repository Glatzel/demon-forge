Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

if ($IsWindows) {
    gh release download -R "XTLS/Xray-core" -p "Xray-windows-64.zip" `
        -O  $ROOT/temp/$name/$name.zip --clobber
}
if ($IsLinux -and ($arch -eq "X64")) {
    gh release download -R "XTLS/Xray-core" -p "Xray-linux-64.zip" `
        -O  $ROOT/temp/$name/$name.zip --clobber
}
if ($IsLinux -and ($arch -eq "Arm64")) {
    gh release download -R "XTLS/Xray-core" -p "Xray-linux-arm64-v8a.zip" `
        -O  $ROOT/temp/$name/$name.zip --clobber
}
if ($IsMacOS) {
    gh release download -R "XTLS/Xray-core" -p "Xray-macos-arm64-v8a.zip" `
        -O  $ROOT/temp/$name/$name.zip --clobber
}
7z x "$ROOT/temp/$name/$name.zip" "-o$env:PREFIX/bin/$name"
if ($IsWindows) {
    Copy-Item $PSScriptRoot/update-geofile.ps1 $env:PREFIX/bin/$name/
}
else {
    Copy-Item $PSScriptRoot/update-geofile.sh $env:PREFIX/bin/$name/
}
