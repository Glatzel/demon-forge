ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
export RUSTC_BOOTSTRAP=1
gh api repos/microsoft/edit/contents/.cargo/release.toml --jq .content | base64 -d > release.toml
cargo_build --git https://github.com/microsoft/edit --tag "v$PKG_VERSION" --config release.toml edit
