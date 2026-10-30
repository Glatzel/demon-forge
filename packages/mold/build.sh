ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cargo_build --git https://github.com/rui314/mold --tag "v$PKG_VERSION" cli
