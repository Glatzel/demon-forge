$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$env:RUSTC_BOOTSTRAP = "1"
gh api repos/microsoft/edit/contents/.cargo/release.toml --jq .content | base64 -d > release.toml
cargo-build --git https://github.com/microsoft/edit --tag "v$env:PKG_VERSION" --config release.toml edit
