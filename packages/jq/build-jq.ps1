New-Item $env:PREFIX/bin/jq -ItemType Directory
Copy-Item "$env:RECIPE_DIR/../../temp/jq/jq.exe" "$env:PREFIX/bin/jq/jq.exe"
