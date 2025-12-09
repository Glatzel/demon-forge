Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/bin/$name -ItemType Directory

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
