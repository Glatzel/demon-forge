$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo-build $env:PKG_NAME
Copy-Item "$env:RECIPE_DIR/etc/" "$env:PREFIX/" -recurse
