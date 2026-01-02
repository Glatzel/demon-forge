Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-github -repo "Glatzel/fornax"
update-recipe -version $latest_version

Set-Location $ROOT/temp/$name
gh repo clone Glatzel/fornax
Set-Location fornax
git checkout tags/"v$latest_version" -b "$latest_version-branch"
(Get-Content -Path "./scripts/setup.ps1") -replace "sudo ", "" | Set-Content -Path "./scripts/setup.ps1"
& ./scripts/setup.ps1
Set-Location ./crates/fornax-py
if ($env:DIST_BUILD) {
    pixi run maturin build --out ./dist --profile release
}
else {
    pixi run maturin build --out ./dist
}
Set-Location $PSScriptRoot
build-pkg
