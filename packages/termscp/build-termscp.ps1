$JITTER = "$env:BUILD_PREFIX\.cargo\registry\src\index.crates.io-1949cf8c6b5b557f\aws-lc-sys-0.35.0\aws-lc\third_party\jitterentropy\jitterentropy-library"
$env:CL = "/I`"$JITTER`""
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
build-cargo-package ${env:PKG_NAME}
