just assemble-codex-package --cargo-profile release --package-dir out --target
Copy-Item $env:RECIPE_DIR/win/etc/ $env:PREFIX/ -recurse
