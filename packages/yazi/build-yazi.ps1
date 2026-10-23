$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo-build --path ./yazi-fm --profile release-windows
cargo-build --path ./yazi-cli --profile release-windows
