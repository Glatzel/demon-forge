$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

Copy-Item $PSScriptRoot/build/* ./ -Recurse
& ./vcpkg-setup.ps1
& ./vcpkg-install.ps1
New-Item $env:PREFIX/$name -ItemType Directory
Copy-Item "./$name/installed/*" "$env:PREFIX/$name" -Recurse
