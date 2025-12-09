Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-crateio -name $name
update-recipe -version $latest_version

cargo install $name --root $ROOT/temp/$name --force `
    --config 'profile.release.codegen-units=1' `
    --config 'profile.release.debug=false' `
    --config 'profile.release.lto="fat"' `
    --config 'profile.release.opt-level=3' `
    --config 'profile.release.strip=true'

build-pkg
