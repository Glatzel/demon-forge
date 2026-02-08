Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "ImageMagick/ImageMagick"
$latest_version = "$latest_version".Replace("-", ".")
update-recipe -version $latest_version

