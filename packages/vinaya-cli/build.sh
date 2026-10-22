ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
set -- $(get-cargo-arg)
cd ./tools/vinaya/crates/vinaya-cli
cargo install --path . "$@"
