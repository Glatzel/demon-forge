ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
set -- $(get_cargo_arg)
cargo_build --git https://github.com/Glatzel/toolbox --tag "v$PKG_VERSION" orc
