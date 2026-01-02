Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/installed/*" "$env:PREFIX/$name" -Recurse
