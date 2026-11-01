ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
if [ "$(uname)" = "Linux" ]; then
    ls "$PREFIX/lib/pkgconfig" | grep -Ei 'fontconfig|freetype|expat|uuid'
    PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig" pkg-config --debug --libs --cflags fontconfig 2>&1 | tail -30
    export LIBCLANG_PATH="$BUILD_PREFIX/lib"
fi
process_skills ./skills
cargo_build --path ./moli
