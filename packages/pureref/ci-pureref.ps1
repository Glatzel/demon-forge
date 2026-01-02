Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-url -url "https://www.pureref.com/download.php" -pattern 'selected value="(\d+\.\d+\.\d+)"'
update-recipe -version $latest_version
build-pkg
