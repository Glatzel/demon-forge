New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "$env:RECIPE_DIR/temp/ImageMagick*/*" "$env:PREFIX/bin/"
