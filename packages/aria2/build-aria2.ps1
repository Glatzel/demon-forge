Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
gh release download -R $name/$name -p "$name-*-win-64bit*.zip" `
    -O  $ROOT/temp/$name/$name.zip --clobber
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "$ROOT/temp/$name/*/aria2c.exe" "$env:PREFIX/bin/aria2c.exe"
