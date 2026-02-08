$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

aria2c -c -x16 -s16 -d "$env:PREFIX/bin" `
    "https://aka.ms/vs/$env:PKG_VERSION/release/vs_BuildTools.exe" `
    -o "vs_BuildTools.exe"
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
