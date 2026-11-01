ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
if [ "$(uname)" = "Linux" ]; then
    export LIBCLANG_PATH="$BUILD_PREFIX/lib"
    export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
fi
cargo_build --git https://github.com/lexmount/moli --tag "v$PKG_VERSION" moli
