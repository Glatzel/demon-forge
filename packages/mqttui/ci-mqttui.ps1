Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github "EdJoPaTo/$name"
dispatch-workflow -version $latest_version
