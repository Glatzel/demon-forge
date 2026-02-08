Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-url  "https://learn.microsoft.com/en-us/visualstudio/releases/" 'Version (\d+\.\d+\.\d+)'
update-recipe -version $([Version]"$latest_version").Major
build-pkg
