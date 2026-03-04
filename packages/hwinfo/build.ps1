$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$version="$env:PKG_VERSION".Replace(".","")
aria2c -c -x16 -s16 -d ./ `
    "https://www.hwinfo.com/files/hwi_$version.zip" `
    -o "${env:PKG_NAME}.zip"
7z x "${env:PKG_NAME}.zip" "-o$env:PREFIX/bin/${env:PKG_NAME}"
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"
