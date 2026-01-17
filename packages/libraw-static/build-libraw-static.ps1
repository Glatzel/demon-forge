Copy-Item $PSScriptRoot/build/* ./ -Recurse
& ./vcpkg-setup.ps1
& ./vcpkg-install.ps1
Set-Location $PSScriptRoot
New-Item $env:PREFIX/libraw -ItemType Directory
Copy-Item "./libraw/installed/*" "$env:PREFIX/libraw" -Recurse
