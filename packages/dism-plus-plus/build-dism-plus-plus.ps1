Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name/*" "$env:PREFIX/bin/$name" -Recurse

# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "menu-$name.json" "$env:PREFIX/Menu"
