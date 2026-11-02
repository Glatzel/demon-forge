ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cargo_build --git https://github.com/xerj-org/xerj --tag "v$PKG_VERSION-rc.100" -p xerj-server
