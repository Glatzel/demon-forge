Set-Location $PSScriptRoot
. ../../scripts/setup.ps1

$current_version = get-current-version
Write-Output "Current Version: $current_version"

$latest_version = get_latest_version -repo "ImageMagick/ImageMagick"
Remove-Item ../../temp/imagemagick -Recurse -ErrorAction SilentlyContinue
New-Item ../../temp/imagemagick -ItemType Directory
New-Item ../../temp/imagemagick/expand -ItemType Directory
aria2c -c -x16 -s16 -d ./ "https://imagemagick.org/archive/binaries/ImageMagick-$latest_version-portable-Q16-x64.zip" `
    -o ../../temp/imagemagick/magick.zip
Expand-Archive ../../temp/imagemagick/magick.zip ../../temp/imagemagick/
$latest_version = "$latest_version".Replace("-", ".")
Write-Output "Latest Version: $latest_version"

update-recipe -version $latest_version
build_pkg
test_pkg