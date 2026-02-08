Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-url -url "https://nssm.cc/download" -pattern 'nssm (\d+\.\d+)'
update-recipe -version $latest_version
