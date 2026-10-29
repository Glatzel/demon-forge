ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
if [[ "$TARGET_PLATFORM" == "linux-aarch64" ]]; then
    export CARGO_BUILD_JOBS=1
fi
cargo_build --path apps/solidcraft-cli
cargo_build --path apps/solidcraft
mkdir $PREFIX/Menu
cp "${RECIPE_DIR}/${PKG_NAME}.json" "$PREFIX/Menu"
