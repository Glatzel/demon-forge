New-Item $env:PREFIX/bin/nuget -ItemType Directory
Copy-Item "$env:RECIPE_DIR/../../temp/nuget/nuget.exe" "$env:PREFIX/bin/nuget/nuget.exe"
