$env:CARGO_BUILD_JOBS=1
$env:CODEX_REPO_ROOT=Resolve-Path "."
python scripts/build_codex_package.py `
    --target "x86_64-pc-windows-msvc" `
    --variant codex `
    --cargo-profile release `
    --package-dir "$env:PREFIX" `
    --force `
    --strip all `
    --strip-tool llvm-strip
Copy-Item $env:RECIPE_DIR/win/etc/ $env:PREFIX/ -recurse
