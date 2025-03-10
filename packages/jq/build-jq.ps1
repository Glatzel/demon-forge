New-Item $env:PREFIX/scripts -ItemType Directory
Copy-Item "$env:RECIPE_DIR/../../temp/jq/jq.exe" "$env:PREFIX/scripts/jq.exe"
