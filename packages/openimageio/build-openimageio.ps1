$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

Copy-Item $PSScriptRoot/build/* ./ -Recurse
& ./scripts/pixi-setup.ps1
& ./scripts/clone-repo.ps1
& ./scripts/vcpkg-setup.ps1
& ./scripts/vcpkg-install.ps1
& ./scripts/build-oiio.ps1
& ./scripts/copy-item.ps1
New-Item $env:PREFIX/bin/openimageio -ItemType Directory
Copy-Item "./$name/dist/*" "$env:PREFIX/bin/$name"
