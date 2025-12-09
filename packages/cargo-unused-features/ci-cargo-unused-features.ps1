Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-crateio -name $name
update-recipe -version $latest_version

cargo install $name --locked --force --root $ROOT/temp/$name `
  --config 'profile.release.codegen-units=1' `
  --config 'profile.release.debug=false' `
  --config 'profile.release.lto="fat"' `
  --config 'profile.release.opt-level=3' `
  --config 'profile.release.strip=true'
if ($IsWindows) {
    Rename-Item $ROOT/temp/$name/bin/unused-features.exe $ROOT/temp/$name/bin/$name.exe
}
else {
    Rename-Item $ROOT/temp/$name/bin/unused-features $ROOT/temp/$name/bin/$name
}

build-pkg
