New-Item $env:PREFIX/bin/oiiotool -ItemType Directory
Copy-Item "$env:RECIPE_DIR/../oiiotool_build/dist/*" "$env:PREFIX/bin/oiiotool"
