Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = [Version](get-version-text $(pixi search 7zip) 'Version\s+([0-9]+\.[0-9]+)')
dispatch-workflow $latest_version
