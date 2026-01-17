$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Copy-Item $PSScriptRoot/build/* ./ -Recurse
& ./vcpkg-setup.ps1
& ./vcpkg-install.ps1
New-Item $env:PREFIX/libraw -ItemType Directory
Copy-Item "./installed/*" "$env:PREFIX/libraw" -Recurse
