ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cargo_build --git https://github.com/xerj-org/xerj --tag "v$PKG_VERISON-rc.100"
