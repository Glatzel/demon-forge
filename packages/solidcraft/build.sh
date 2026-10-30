ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cargo_build  --git https://github.com/tangency-labs/solidcraft --tag "v$PKG_VERSION" solidcraft-cli
cargo_build  --git https://github.com/tangency-labs/solidcraft --tag "v$PKG_VERSION" solidcraft
mkdir $PREFIX/Menu
cp "${RECIPE_DIR}/${PKG_NAME}.json" "$PREFIX/Menu"
