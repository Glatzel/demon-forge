python scripts/build_codex_package.py `
    --target "x86_64-pc-windows-msvc" `
    --variant open-interpreter `
    --cargo-profile release `
    --package-dir "$env:PREFIX" `
    --force
llvm-strip "$env:PREFIX/bin/interpreter.exe"
Remove-Item "$env:PREFIX/bin/i.exe"
llvm-strip "$env:PREFIX/bin/codex-code-mode-host.exe"
