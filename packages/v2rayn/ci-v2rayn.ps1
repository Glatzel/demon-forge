Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-github -repo "https://github.com/2dust/v2rayN"
update-recipe -version $latest_version
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
build-pkg
