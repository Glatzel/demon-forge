Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "akinomyoga/ble.sh"
dispatch-workflow $latest_version.Split('-')[0]
