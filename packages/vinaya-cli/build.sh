ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cd ./tools/vinaya/crates/vinaya-cli
cargo_build --path . "$@"
