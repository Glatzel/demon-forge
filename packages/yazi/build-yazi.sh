ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cargo_build --path ./yazi-fm
cargo_build --path ./yazi-cli
