Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

cargo install cargo-machete --root $ROOT/temp/$name --force
if ($IsWindows) {
    $latest_version = & $ROOT/temp/$name/bin/cargo-machete.exe --version
    update-recipe -version $latest_version
}

build-pkg
