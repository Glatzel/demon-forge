Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name=get-name
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "C:/temp/Calibre Portable/*" "$env:PREFIX/bin/$name" -Recurse
