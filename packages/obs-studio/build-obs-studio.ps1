Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

gh release download -R obsproject/$name -p "*-Windows-x64.zip" `
    -O  $ROOT/temp/$name/$name.zip --clobber
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name/*" "$env:PREFIX/bin/$name" -Recurse
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
