Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$version = get-version-text "$(curl -sIL https://www.rhino3d.com/download/rhino-for-windows/8/latest/direct?email=users.noreply.github.com)"'rhino_en-us_(\d+\.\d+\.\d+\.\d+).exe'
dispatch-workflow $version
