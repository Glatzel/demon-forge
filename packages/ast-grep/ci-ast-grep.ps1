Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$env:CONDA_OVERRIDE_GLIBC='2.28'
$latest_version = get-version-crateio -name $name
dispatch-workflow $latest_version
