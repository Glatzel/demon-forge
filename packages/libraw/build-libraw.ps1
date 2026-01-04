Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

Copy-Item $PSScriptRoot/build/* $ROOT/temp/$name/ -Recurse
& $ROOT/temp/$name//vcpkg-setup.ps1
& $ROOT/temp/$name//vcpkg-install.ps1

Set-Location $PSScriptRoot
New-Item $env:PREFIX/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/installed/*" "$env:PREFIX/$name" -Recurse
