Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-crateio $name
update-recipe -version $latest_version

cargo install $name --root $ROOT/temp/$name --force
if ($IsWindows) {
    $latest_version = & $ROOT/temp/$name/bin/$name.exe -V
    $latest_version ="$latest_version".Split(' ')[1]
}

build-pkg
