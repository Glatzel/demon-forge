Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "LibRaw/LibRaw"
$latest_version = "$latest_version".Replace("b", "")
dispatch-workflow $latest_version
Set-Location $PSScriptRoot
