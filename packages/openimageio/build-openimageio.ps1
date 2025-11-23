Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
New-Item $env:PREFIX/bin/openimageio -ItemType Directory
Copy-Item "$ROOT/temp/$name/dist/*" "$env:PREFIX/bin/$name"
