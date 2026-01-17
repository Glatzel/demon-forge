Copy-Item $PSScriptRoot/build/* $env:SRC_DIR -Recurse
& $env:SRC_DIR/scripts/pixi-setup.ps1
& $env:SRC_DIR/scripts/clone-repo.ps1
& $env:SRC_DIR/scripts/vcpkg-setup.ps1
& $env:SRC_DIR/scripts/vcpkg-install.ps1
& $env:SRC_DIR/scripts/build-oiio.ps1
& $env:SRC_DIR/scripts/copy-item.ps1
New-Item $env:PREFIX/bin/openimageio -ItemType Directory
Copy-Item "./${env:PKG_NAME}/dist/*" "$env:PREFIX/bin/${env:PKG_NAME}"
