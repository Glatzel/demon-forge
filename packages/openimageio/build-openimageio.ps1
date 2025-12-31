Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Copy-Item $PSScriptRoot/build/* $ROOT/temp/$name/ -Recurse
& $ROOT/temp/$name/scripts/pixi-setup.ps1
& $ROOT/temp/$name/scripts/clone-repo.ps1
& $ROOT/temp/$name/scripts/vcpkg-setup.ps1
& $ROOT/temp/$name/scripts/vcpkg-install.ps1
& $ROOT/temp/$name/scripts/build-oiio.ps1
& $ROOT/temp/$name/scripts/copy-item.ps1
New-Item $env:PREFIX/bin/openimageio -ItemType Directory
Copy-Item "$ROOT/temp/$name/dist/*" "$env:PREFIX/bin/$name"
