@echo off
setlocal

for %%I in (
    cargo
    cargo-clippy
    cargo-fmt
    cargo-miri
    clippy-driver
    rls
    rust-analyzer
    rust-gdb
    rust-gdbgui
    rust-lldb
    rustc
    rustdoc
    rustfmt
    rustup
) do (
    if not exist "%PREFIX%\bin\%%I.exe" (
        mklink "%PREFIX%\bin\%%I.exe" "%PREFIX%\.cargo\bin\rustup.exe"
    )
)

endlocal