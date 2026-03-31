ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
if [ "$(uname)" = "Linux" ]; then
    export LIBCLANG_PATH="$BUILD_PREFIX/lib"
fi
set -- $(get_cargo_arg)
cargo install --path ./easytier "$@"
