Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($env:DIST_BUILD) {
    cargo install $name --root $env:PREFIX --locked --force `
        --config 'profile.release.codegen-units=1' `
        --config 'profile.release.debug=false' `
        --config 'profile.release.lto="fat"' `
        --config 'profile.release.opt-level=3' `
        --config 'profile.release.strip=true'
}
else {
    cargo install $name --root $env:PREFIX --locked --force `
        --config 'profile.release.opt-level=0' `
        --config 'profile.release.debug=false' `
        --config 'profile.release.codegen-units=256' `
        --config 'profile.release.lto="off"' `
        --config 'profile.release.strip=false'
}
