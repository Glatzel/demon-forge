Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/bin/$name -ItemType Directory
if ($IsWindows) {
    gh release download -R 2dust/v2rayN -p "v2rayN-windows-64-SelfContained.zip" `
        -O  $ROOT/temp/$name/$name.zip --clobber
}
# if ($IsMacOS) {
#     gh release download -R 2dust/v2rayN -p "v2rayN-macos-arm64.zip" `
#         -O  $ROOT/temp/$name/$name.zip --clobber
# }
# if ($IsLinux -and $arch -eq "X64") {
#     gh release download -R 2dust/v2rayN -p "v2rayN-linux-64.zip" `
#         -O  $ROOT/temp/$name/$name.zip --clobber
# }
# if ($IsLinux -and $arch -eq "Arm64") {
#     gh release download -R 2dust/v2rayN -p "v2rayN-linux-arm64.zip" `
#         -O  $ROOT/temp/$name/$name.zip --clobber

# }
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"
if ($IsWindows) {
    Copy-Item "$ROOT/temp/$name/$name/v2rayN-windows-64-SelfContained/*" "$env:PREFIX/bin/$name/" -Recurse
}
# if ($IsMacOS) {
#     Copy-Item "$ROOT/temp/$name/$name/v2rayN-macos-arm64/*" "$env:PREFIX/bin/$name/" -Recurse
# }
# if ($IsLinux -and $arch -eq "X64") {
#     Copy-Item "$ROOT/temp/$name/$name/v2rayN-linux-64/*" "$env:PREFIX/bin/$name/" -Recurse
# }
# if ($IsLinux -and $arch -eq "Arm64") {
#     Copy-Item "$ROOT/temp/$name/$name/v2rayN-linux-arm64/*" "$env:PREFIX/bin/$name/" -Recurse
# }
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
