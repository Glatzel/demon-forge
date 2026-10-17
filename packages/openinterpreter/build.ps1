$env:CODEX_REPO_ROOT=Resolve-Path "."
python codex-rs/scripts/write_model_compatibility_catalog.py
jq '[.entries[] | select(.id != null) | {id, aliases, context_window}]' codex-rs/codex-api/model_compatibility_catalog.json
python scripts/build_codex_package.py `
    --target "x86_64-pc-windows-msvc" `
    --variant open-interpreter `
    --cargo-profile release `
    --package-dir "$env:PREFIX" `
    --force
llvm-strip "$env:PREFIX/bin/interpreter.exe"
Remove-Item "$env:PREFIX/bin/i.exe"
llvm-strip "$env:PREFIX/bin/codex-code-mode-host.exe"
Copy-Item $env:RECIPE_DIR/win/etc/ $env:PREFIX/ -recurse
