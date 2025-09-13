Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "$ROOT/temp/$name/*" "$env:PREFIX/bin/"
if ($IsLinux) {
    chmod +rwx "$env:PREFIX/bin/$name"
}
