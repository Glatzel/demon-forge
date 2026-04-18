Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version=get-version-winget "x/Xanashi/Icaros"
$latest_version="$latest_version".replace("000","0")
update-recipe $latest_version
