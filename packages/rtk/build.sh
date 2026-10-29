ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cargo_build --git https://github.com/rtk-ai/rtk --tag "v$PKG_VERSION" rtk
