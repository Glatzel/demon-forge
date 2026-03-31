Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$version = get-version-text "$(curl -sIL https://www.adobe.com/go/dng_converter_win)".Replace("_", ".") 'AdobeDNGConverter.x64.(.+)\.exe'
update-recipe $version
