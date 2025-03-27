New-Item $env:PREFIX/bin/openimageio -ItemType Directory
Copy-Item "$env:RECIPE_DIR/../openimageio_build/dist/*" "$env:PREFIX/bin/openimageio"
