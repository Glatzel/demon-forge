new-item $env:PREFIX/Scripts -itemType Directory -Force -ErrorAction SilentlyContinue
Copy-Item $env:RECIPE_DIR/dnc-init.ps1 $env:PREFIX/Scripts/
Copy-Item $env:RECIPE_DIR/dnc-init.bat $env:PREFIX/Scripts/
