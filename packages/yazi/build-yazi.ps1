$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install --path ./yazi-fm --profile release-windows @(get-cargo-arg)
cargo install --path ./yazi-cli --profile release-windows @(get-cargo-arg)
