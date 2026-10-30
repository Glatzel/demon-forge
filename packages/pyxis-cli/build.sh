ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cargo_build --git https://github.com/Glatzel/pyxis --tag "v$PKG_VERSION" pyxis-cli
