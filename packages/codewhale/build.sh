ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cargo_build --git https://github.com/codewhale-hq/CodeWhale --tag "v$PKG_VERSION" codewhale-cli
