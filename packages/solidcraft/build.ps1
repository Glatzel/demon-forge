$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo-build --path apps/solidcraft-cli
cargo-build --path apps/solidcraft
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"
