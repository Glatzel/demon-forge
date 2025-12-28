Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-github -repo "Glatzel/$name"
update-recipe -version $latest_version

Set-Location $ROOT/temp/$name
gh repo clone Glatzel/$name 
Set-Location $name
git checkout tags/"v$latest_version" -b "$latest_version-branch"

Set-Location $PSScriptRoot
pixi run rattler-build build
Set-Location $ROOT
