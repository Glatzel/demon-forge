ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
set -- $(get_cargo_arg)
cargo install --path apps/solidcraft-cli "$@"
cargo install --path apps/solidcraft "$@"
mkdir $PREFIX/Menu
cp "${RECIPE_DIR}/${PKG_NAME}.json" "$PREFIX/Menu"