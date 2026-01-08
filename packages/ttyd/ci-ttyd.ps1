Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "tsl0922/$name"
update-recipe -version $latest_version
build-pkg
if ($IsLinux -and $arch -eq 'X64') {
    build-pkg --target_platform 'win-64'
}
