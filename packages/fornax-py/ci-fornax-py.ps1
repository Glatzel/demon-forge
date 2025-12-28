Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-github -repo "Glatzel/$name"
update-recipe -version $latest_version
Set-Location $ROOT/temp/$name
gh repo clone Glatzel/$name
Set-Location $name
git checkout tags/"v$latest_version" -b "$latest_version-branch"
& ./scripts/setup.ps1
Set-Location ./crates/fornax-py
pixi run maturin build --out ./dist --profile release

Set-Location $PSScriptRoot
build-pkg
