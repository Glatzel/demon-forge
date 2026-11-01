ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cargo_build --git https://github.com/lexmount/moli --tag "v$PKG_VERSION" moli

