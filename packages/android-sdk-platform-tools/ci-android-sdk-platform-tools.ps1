Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/setup.ps1
Remove-Item $ROOT/temp/android-sdk-platform-tools -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/android-sdk-platform-tools -ItemType Directory
aria2c -c -x16 -s16 -d $ROOT/temp/android-sdk-platform-tools/ `
    "https://googledownloads.cn/android/repository/platform-tools-latest-windows.zip" `
    -o platform-tools.zip
Expand-Archive $ROOT/temp/android-sdk-platform-tools/platform-tools.zip $ROOT/temp/android-sdk-platform-tools/

build_pkg
