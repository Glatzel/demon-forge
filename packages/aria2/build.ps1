New-Item $env:PREFIX/scripts -ItemType Directory
Copy-Item "$env:RECIPE_DIR/../../temp/aria2/**aria2c.exe" "$env:PREFIX/scripts/aria2c.exe"
