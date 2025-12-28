Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-github -repo "Glatzel/pyxis"
update-recipe -version $latest_version
Set-Location $ROOT/temp/$name

gh repo clone Glatzel/pyxis
Set-Location pyxis
git checkout tags/"v$latest_version" -b "$latest_version-branch"
Set-Location rust
& ./scripts/setup.ps1
if ($env:DIST_BUILD) {
    cargo build --bin pyxis --release
}
else {
    cargo build --bin pyxis 
}
Set-Location $PSScriptRoot
build-pkg
