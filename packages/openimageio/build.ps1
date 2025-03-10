New-Item $env:PREFIX/scripts -ItemType Directory
Copy-Item "$env:RECIPE_DIR/../openimageio/dist/bin/*" "$env:PREFIX/scripts/"
