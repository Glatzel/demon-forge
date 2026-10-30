ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
if [ "$(uname)" = "Linux" ]; then
    export LIBCLANG_PATH="$BUILD_PREFIX/lib"
fi
cargo_build --git https://github.com/EasyTier/EasyTier --tag "v$PKG_VERSION" easytier
