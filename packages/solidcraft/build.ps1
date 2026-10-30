$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo-build --git https://github.com/tangency-labs/solidcraft --tag "v$env:PKG_VERSION" solidcraft-cli
cargo-build --git https://github.com/tangency-labs/solidcraft --tag "v$env:PKG_VERSION" solidcraft
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"
