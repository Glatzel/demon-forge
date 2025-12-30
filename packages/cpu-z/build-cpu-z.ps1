Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
& $env:BUILD_PREFIX/bin/selenium python download.py
$zipfile = (Get-ChildItem "$ROOT/temp/$name/*.zip")[0]
7z x "$zipfile" "-o$ROOT/temp/$name/$name"
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name/*" "$env:PREFIX/bin/$name" -Recurse
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
