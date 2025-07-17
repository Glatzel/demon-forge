Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

if ($env:CI) {
    rustup toolchain install nightly --profile=minimal
}
cargo +nightly install cargo-llvm-cov --locked --root $ROOT/temp/$name --force
if ($IsWindows) {
    $latest_version = & $ROOT/temp/$name/bin/cargo-llvm-cov.exe llvm-cov -V
    $latest_version = "$latest_version".Split(" ")[1]
    update-recipe -version $latest_version
}


build-pkg
