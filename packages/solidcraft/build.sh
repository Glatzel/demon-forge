ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cargo_build --path apps/solidcraft-cli
cargo_build --path apps/solidcraft
mkdir $PREFIX/Menu
cp "${RECIPE_DIR}/${PKG_NAME}.json" "$PREFIX/Menu"
