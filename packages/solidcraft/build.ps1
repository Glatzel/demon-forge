$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install --path apps/solidcraft-cli @(Get-Cargo-Arg)
cargo install --path apps/solidcraft @(Get-Cargo-Arg)
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"