Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "$ROOT/temp/$name/pt_linux_arm64" "$env:PREFIX/bin/"
