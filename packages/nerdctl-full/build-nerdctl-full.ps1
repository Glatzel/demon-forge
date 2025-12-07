Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

Copy-Item "$ROOT/temp/$name/$name/*" "$env:PREFIX/" -Recurse\
# do not use bundled runc
Remove-Item "$env:PREFIX/bin/runc"
