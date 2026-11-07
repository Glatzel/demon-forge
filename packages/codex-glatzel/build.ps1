$env:CODEX_HOME="$env:PREFIX"
rtk init -g --codex
Copy-Item $env:RECIPE_DIR/config/* $env:PREFIX/ -recurse
