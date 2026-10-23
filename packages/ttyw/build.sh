ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cd ./tools/ttyw
pixi run install
pixi run build
cargo_build --path .
