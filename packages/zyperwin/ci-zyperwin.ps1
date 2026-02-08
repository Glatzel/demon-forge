Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-github -repo "ZyperWave/ZyperWinOptimize"
dispatch-workflow $latest_version
