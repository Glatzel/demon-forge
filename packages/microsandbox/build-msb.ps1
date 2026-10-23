$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$env:LIBRARY_PATH="$(realpath $PREFIX/lib):$LIBRARY_PATH"
cargo-build --path ./crates/cli
