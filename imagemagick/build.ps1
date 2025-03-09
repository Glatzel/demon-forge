New-Item $env:PREFIX/scripts -ItemType Directory
foreach ($f in Get-ChildItem  "$env:RECIPE_DIR/temp/ImageMagick*/*") {
    Copy-Item $f "$env:PREFIX/scripts/"
}

