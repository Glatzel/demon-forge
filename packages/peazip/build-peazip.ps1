Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

gh release download -R https://github.com/$name/PeaZip -p "peazip_portable-*.WIN64.zip" `
    -O  $ROOT/temp/$name/$name.zip --clobber
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name"
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name_portable*/*" "$env:PREFIX/bin/$name" -Recurse
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
