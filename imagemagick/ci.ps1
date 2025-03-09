Set-Location $PSScriptRoot
. ../scripts/setup.ps1

$current_version = get-current-version
Write-Output "Current Version: $current_version"

$latest_version = get_latest_version -repo "ImageMagick/ImageMagick"
aria2c -c -x16 -s16 -d ./ "https://imagemagick.org/archive/binaries/ImageMagick-$latest_version-portable-Q16-x64.zip" -o magick.zip
Remove-Item ./temp -Recurse -ErrorAction SilentlyContinue
Expand-Archive ./magick.zip ./temp
$latest_version = "$latest_version".Replace("-", ".")
Write-Output "Latest Version: $latest_version"

update-recipe -version $latest_version
build_pkg
test_pkg
