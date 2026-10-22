ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
if [ "$(uname)" = "Linux" ]; then
    LIBCLANG_PATH="$BUILD_PREFIX/lib"
fi
set -- $(get-cargo-arg)
cargo install "$PKG_NAME" "$@"
