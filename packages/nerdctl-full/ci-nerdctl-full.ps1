Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "containerd/nerdctl"
update-recipe -version $latest_version
build-pkg
