ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
export LIBRARY_PATH="$(realpath $PREFIX/lib):$LIBRARY_PATH"
cargo_build --path ./crates/cli
