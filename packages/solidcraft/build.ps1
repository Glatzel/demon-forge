$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo-install --path apps/solidcraft-cli@(get-cargo-arg)
cargo-install --path apps/solidcraft@(get-cargo-arg)
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"
