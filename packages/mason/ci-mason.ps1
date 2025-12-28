Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-github -repo "Glatzel/$name"
update-recipe -version $latest_version

Set-Location $ROOT/temp/$name
gh repo clone $name
Set-Location $name
git checkout tags/"v$latest_version" -b "$latest_version-branch"

& ./scripts/build.ps1 -Release

Set-Location $PSScriptRoot
pixi run rattler-build build
Set-Location $ROOT
