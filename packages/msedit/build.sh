ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
export RUSTC_BOOTSTRAP=1
cargo_build --git https://github.com/microsoft/edit --tag "v$PKG_VERSION" --config .cargo/release.toml edit
