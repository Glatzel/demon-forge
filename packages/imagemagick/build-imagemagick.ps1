$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

gh release download `
    -R "ImageMagick/ImageMagick" `
    -p "ImageMagick-*-portable-Q16-HDRI-x64.7z" `
    -O  ./$name.7z `
    --clobber
7z x "./$name.7z" "-o./$name"
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "$env:RECIPE_DIR/../../temp/$name/$name/*" "$env:PREFIX/bin/$name" -Recurse
