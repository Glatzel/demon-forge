Set-Location $PSScriptRoot
. ../../scripts/setup.ps1

Remove-Item ../../temp/pkg-config-lite -Recurse -ErrorAction SilentlyContinue
New-Item ../../temp/pkg-config-lite -ItemType Directory
aria2c -c -x16 -s16 -d ../../temp/pkg-config-lite/ `
    "https://sourceforge.net/projects/pkgconfiglite/files/0.28-1/pkg-config-lite-0.28-1_bin-win32.zip/download" `
    -o pkg-config-lite.zip
Expand-Archive ../../temp/pkg-config-lite/pkg-config-lite.zip ../../temp/pkg-config-lite/

build_pkg
test_pkg
