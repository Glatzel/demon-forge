Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-latest-version -repo "ImageMagick/ImageMagick"
$latest_version = "$latest_version".Replace("-", ".")

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory

gh release download `
    -R "ImageMagick/ImageMagick" `
    -p "ImageMagick-*-portable-Q16-HDRI-x64.7z" `
    -O  $ROOT/temp/$name/$name.7z `
    --clobber

7z x "$ROOT/temp/$name/$name.7z" "-o$ROOT/temp/$name/$name"
update-recipe -version $latest_version
build-pkg
