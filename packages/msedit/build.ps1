$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$env:RUSTC_BOOTSTRAP = "1"
cargo install --path . --config .cargo/release.toml @(Get-Cargo-Arg)
