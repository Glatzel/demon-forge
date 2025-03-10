New-Item $env:PREFIX/scripts -ItemType Directory
Copy-Item "$env:RECIPE_DIR/../../temp/nuget/nuget.exe" "$env:PREFIX/scripts/"

