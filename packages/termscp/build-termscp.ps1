Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$JITTER = "$env:BUILD_PREFIX\.cargo\registry\src\index.crates.io-1949cf8c6b5b557f\aws-lc-sys-0.35.0\aws-lc\third_party\jitterentropy\jitterentropy-library"

$env:CFLAGS   = "/I`"$JITTER`""
$env:CXXFLAGS = $env:CFLAGS
build-cargo-package $name $name
