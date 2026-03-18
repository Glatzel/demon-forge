Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$repoUrl = "https://github.com/rust-lang/rustup.git"
$latest = git ls-remote --tags --refs $repoUrl |
ForEach-Object {
    ($_ -split "`t")[1] -replace '^refs/tags/', ''
} |
Sort-Object { [version]$_ } |
Select-Object -Last 1

dispatch-workflow $latest
