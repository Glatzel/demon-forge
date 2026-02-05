$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsLinux) {
    $env:LIBCLANG_PATH = "$env:BUILD_PREFIX/lib"
    cargo install $name `
        --root $env:PREFIX `
        --locked `
        --force `
        --config profile.release.debug=false `
        --config profile.release.codegen-units=1 `
        --config 'profile.release.lto="fat"' `
        --config profile.release.opt-level=3 `
        --config profile.release.strip=true
}
else{
    cargo install $name @(Get-Cargo-Arg)
}
