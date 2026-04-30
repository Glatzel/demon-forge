ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
set -- $(get_cargo_arg)
cd ./tools/ttyw
pixi run install
pixi run build
cargo install --path . "$@"
