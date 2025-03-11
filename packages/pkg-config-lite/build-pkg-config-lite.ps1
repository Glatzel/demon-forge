New-Item $env:PREFIX/bin/pkg-config-lite -ItemType Directory
Copy-Item "$env:RECIPE_DIR/../../temp/pkg-config-lite/pkg-config-lite*/bin/pkg-config.exe" "$env:PREFIX/bin/pkg-config-lite/pkg-config.exe"
