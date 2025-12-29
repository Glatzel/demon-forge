Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-github -repo "Glatzel/pyxis"
update-recipe -version $latest_version

install-rust
Set-Location $ROOT/temp/$name
gh repo clone Glatzel/pyxis
Set-Location pyxis
git checkout tags/"v$latest_version" -b "$latest_version-branch"
Set-Location python
if ($env:DIST_BUILD) {
    pixi run maturin build --out ./dist --profile release
}
else {
    pixi run maturin build --out ./dist
}

Set-Location $PSScriptRoot
build-pkg
