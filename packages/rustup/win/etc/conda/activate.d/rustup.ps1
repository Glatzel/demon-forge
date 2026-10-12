
$ErrorActionPreference = "Stop"

$bin = Join-Path $env:PREFIX "bin"
$rustup = Join-Path $env:PREFIX ".cargo\bin\rustup.exe"

New-Item -ItemType Directory -Path $bin -Force | Out-Null

$commands = @(
    "cargo"
    "cargo-clippy"
    "cargo-fmt"
    "cargo-miri"
    "clippy-driver"
    "rls"
    "rust-analyzer"
    "rust-gdb"
    "rust-gdbgui"
    "rust-lldb"
    "rustc"
    "rustdoc"
    "rustfmt"
    "rustup"
)

foreach ($command in $commands) {
    $link = Join-Path $bin "$command.exe"

    if (Test-Path -LiteralPath $link) {
        $item = Get-Item -LiteralPath $link -Force

        if ($item.LinkType -ne "SymbolicLink") {
            Remove-Item -LiteralPath $link -Force
        }
    }

    if (-not (Test-Path -LiteralPath $link)) {
        New-Item -ItemType SymbolicLink -Path $link -Target $rustup |
            Out-Null
    }
}
