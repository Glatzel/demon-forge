Set-Location $PSScriptRoot
. ../scripts/setup.ps1

$current_version = get-current-version
Write-Output "Current Version: $current_version"

$latest_version = get_latest_version -repo "ImageMagick/ImageMagick"
aria2c -c -x16 -s16 -d ./ "https://imagemagick.org/archive/binaries/ImageMagick-$latest_version-portable-Q16-x64.zip" -o magick.zip --all-proxy=http://127.0.0.1:10808
Expand-Archive ./magick.zip ./temp
$latest_version = "$latest_version".Replace("-", ".")
Write-Output "Latest Version: $latest_version"

if($current_version -ne $latest_version){
    gh release download -R jqlang/jq -p "jq-windows-amd64.exe" -O jq.exe --clobber
    update-recipe -version $latest_version
    build_pkg
    test_pkg
}
