Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "ChristopherHX/github-act-runner"
dispatch-workflow $latest_version
