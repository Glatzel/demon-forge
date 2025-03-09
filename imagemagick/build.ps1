New-Item $env:PREFIX/scripts -ItemType Directory
foreach ($f in Get-ChildItem  "$env:RECIPE_DIR/temp/ImageMagick-*-portable-Q16-x64/*") {
    Copy-Item $f "$env:PREFIX/scripts/"
}

