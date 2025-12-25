Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name/target/*/zed.exe" "$env:PREFIX/bin/zed.exe"
Copy-Item "$ROOT/temp/$name/$name/target/*/cli.exe" "$env:PREFIX/bin/zed-cli.exe"

# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
