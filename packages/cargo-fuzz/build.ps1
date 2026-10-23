$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo-install $env:PKG_NAME
Copy-Item "$env:RECIPE_DIR/etc/" "$env:PREFIX/" -recurse
