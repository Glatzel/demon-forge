Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name=get-name
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name_portable*/*" "$env:PREFIX/bin/$name" -Recurse
