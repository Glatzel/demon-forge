New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "$env:RECIPE_DIR/jq.exe" "$env:PREFIX/bin/jq.exe"
