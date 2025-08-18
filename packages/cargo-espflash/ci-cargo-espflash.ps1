Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

cargo install cargo-espflash --root $ROOT/temp/$name --force
if ($IsWindows) {
    $latest_version = & $ROOT/temp/$name/bin/cargo-espflash.exe espflash -V
    $latest_version ="$latest_version".Split(' ')[1]
    update-recipe -version $latest_version
}

build-pkg
