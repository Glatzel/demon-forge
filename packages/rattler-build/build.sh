ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cargo_build --git https://github.com/prefix-dev/rattler-build --tag "v$PKG_VERSION" rattler-build
