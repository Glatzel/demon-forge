ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
if [ "$(uname)" = "Linux" ]; then
    OPENSSL_DIR="$BUILD_PREFIX"
    export OPENSSL_DIR
fi
set -- $(get_cargo_arg)
cargo install "$PKG_NAME" "$@"
mv -f "$PREFIX/bin/unused-features" "$PREFIX/bin/$PKG_NAME"
