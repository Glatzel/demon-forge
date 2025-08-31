Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

cargo install $name --locked --force --root $ROOT/temp/$name
if ($IsWindows) {
    Rename-Item $ROOT/temp/$name/bin/unused-features.exe $ROOT/temp/$name/bin/$name.exe
    $latest_version = & $ROOT/temp/$name/bin/$name.exe -V
    $latest_version ="$latest_version".Split(" ")[1]
    update-recipe -version $latest_version
}
else{
      Rename-Item $ROOT/temp/$name/bin/unused-features $ROOT/temp/$name/bin/$name
}

build-pkg
