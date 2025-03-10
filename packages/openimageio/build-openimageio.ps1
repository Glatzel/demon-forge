New-Item $env:PREFIX/scripts -ItemType Directory
Copy-Item "$env:RECIPE_DIR/../openimageio_build/dist/bin/*" "$env:PREFIX/scripts/"
