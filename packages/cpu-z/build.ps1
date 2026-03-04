$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
aria2c -c -x16 -s16 -d ./ `
    "https://download.cpuid.com/cpu-z/cpu-z_${env:PKG_VERSION}-en.zip" `
    -o "${env:PKG_NAME}.zip"
7z x "${env:PKG_NAME}.zip" "-o$env:PREFIX/bin"
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"
