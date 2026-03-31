Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = [Version](get-version-conda-forge 7zip)
update-recipe $latest_version
