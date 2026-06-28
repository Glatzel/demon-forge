$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$env:LIBRARY_PATH="$(realpath $PREFIX/lib):$LIBRARY_PATH"
cargo install --path ./crates/cli @(Get-Cargo-Arg)
