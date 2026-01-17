Copy-Item $PSScriptRoot/build/* ./ -Recurse
& ./vcpkg-setup.ps1
& ./vcpkg-install.ps1
New-Item $env:PREFIX/proj -ItemType Directory
Copy-Item "./proj/installed/*" "$env:PREFIX/proj" -Recurse
