ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cargo_build --git https://github.com/herdrdev/herdr --tag "v$PKG_VERSION"
