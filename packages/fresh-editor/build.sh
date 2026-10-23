ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
if [ "$(uname)" = "Linux" ]; then
    LIBCLANG_PATH="$BUILD_PREFIX/lib"
fi
cargo_build $PKG_NAME
