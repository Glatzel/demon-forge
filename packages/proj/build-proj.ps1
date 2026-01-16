Copy-Item $PSScriptRoot/build/* ./ -Recurse
& ./vcpkg-setup.ps1
& ./vcpkg-install.ps1
New-Item $env:PREFIX/${env:PKG_NAME} -ItemType Directory
Copy-Item "./${env:PKG_NAME}/installed/*" "$env:PREFIX/${env:PKG_NAME}" -Recurse
