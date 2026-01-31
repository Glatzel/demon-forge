& ./scripts/build.ps1 -Release
New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
Copy-Item "./bin/Mason/*" "$env:PREFIX/bin/${env:PKG_NAME}" -Recurse
Copy-Item $env:RECIPE_DIR/post-link.bat $PREFIX/bin/.mason-post-link.bat
Copy-Item $env:RECIPE_DIR/pre-unlink.bat $PREFIX/bin/.mason-pre-unlink.bat
