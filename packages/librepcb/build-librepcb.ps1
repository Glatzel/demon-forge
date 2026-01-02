Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    "https://download.librepcb.org/releases/$(get-current-version)/librepcb-$(get-current-version)-windows-x86_64.zip" `
    -o "$name.zip"
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name/*" "$env:PREFIX/bin/$name" -Recurse
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
