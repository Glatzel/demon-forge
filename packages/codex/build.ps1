just assemble-codex-package --cargo-profile release --package-dir out --target x86_64-pc-windows-msvc
Copy-Item $env:RECIPE_DIR/win/etc/ $env:PREFIX/ -recurse
