ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
export LIBRARY_PATH="$(realpath $PREFIX/lib):$LIBRARY_PATH"
set -- $(get-cargo-arg)
cargo install --path ./crates/cli "$@"
