New-Item $env:PREFIX/bin/aria2 -ItemType Directory
Copy-Item "$env:RECIPE_DIR/../../temp/aria2/*/aria2c.exe" "$env:PREFIX/bin/aria2/aria2c.exe"
