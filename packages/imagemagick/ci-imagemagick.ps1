Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name=get-name

$current_version = get-current-version
Write-Output "Current Version: $current_version"

$latest_version = get_latest_version -repo "ImageMagick/ImageMagick"
Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
New-Item $ROOT/temp/$name/expand -ItemType Directory
aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    "https://$name.org/archive/binaries/ImageMagick-$latest_version-portable-Q16-HDRI-x64.zip" `
    -o "$name.zip"
Expand-Archive $ROOT/temp/$name/$name.zip $ROOT/temp/$name/
$latest_version = "$latest_version".Replace("-", ".")
Write-Output "Latest Version: $latest_version"

update-recipe -version $latest_version
build_pkg
