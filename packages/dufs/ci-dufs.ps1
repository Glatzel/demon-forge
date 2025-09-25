Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

cargo install $name --root $ROOT/temp/$name --force
if ($IsWindows) {
    $latest_version = & $ROOT/temp/$name/bin/$name.exe $name -V
    update-recipe -version $latest_version
}

# build-pkg
