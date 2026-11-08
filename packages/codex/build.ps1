Copy-Item $env:RECIPE_DIR/win/etc/ $env:PREFIX/ -recurse
just assemble-codex-package --cargo-profile release --package-dir "$env:PREFIX" --target x86_64-pc-windows-msvc
