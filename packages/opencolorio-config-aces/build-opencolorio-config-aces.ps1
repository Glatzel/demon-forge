Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/ocio -ItemType Directory
Copy-Item "$ROOT/temp/$name/*" "$env:PREFIX/ocio/" -Recurse
