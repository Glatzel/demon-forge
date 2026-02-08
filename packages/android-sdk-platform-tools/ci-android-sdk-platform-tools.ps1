Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-url -url "https://developer.android.com/tools/releases/platform-tools" -pattern '([0-9]+\.[0-9]+\.[0-9]+)'
update-recipe -version $latest_version

