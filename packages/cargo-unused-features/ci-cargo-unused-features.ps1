Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-crateio -name $name
update-recipe -version $latest_version

cargo install $name --locked --force --root $ROOT/temp/$name
if ($IsWindows) {
    Rename-Item $ROOT/temp/$name/bin/unused-features.exe $ROOT/temp/$name/bin/$name.exe
}
else {
    Rename-Item $ROOT/temp/$name/bin/unused-features $ROOT/temp/$name/bin/$name
}

build-pkg
