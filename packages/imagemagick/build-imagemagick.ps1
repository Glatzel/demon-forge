New-Item $env:PREFIX/bin/imagemagick -ItemType Directory
foreach ($f in Get-ChildItem  "$env:RECIPE_DIR/../../temp/imagemagick/ImageMagick-*-portable-Q16-HDRI-x64/*") {
    Copy-Item $f "$env:PREFIX/bin/imagemagick"
}
