$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location ./tools/ttyw
pixi run install
pixi run build
cargo install --path ./tools/orc @(Get-Cargo-Arg)
