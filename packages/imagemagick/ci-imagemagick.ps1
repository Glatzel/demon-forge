Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

$latest_version = get-latest-version -repo "ImageMagick/ImageMagick"
Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
New-Item $ROOT/temp/$name/expand -ItemType Directory
aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    "https://$name.org/archive/binaries/ImageMagick-$latest_version-portable-Q16-HDRI-x64.zip" `
    -o "$name.zip"
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name"
$latest_version = "$latest_version".Replace("-", ".")

update-recipe -version $latest_version
build-pkg
