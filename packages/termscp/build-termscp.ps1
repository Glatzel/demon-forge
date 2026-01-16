$JITTER = "$env:BUILD_PREFIX\.cargo\registry\src\index.crates.io-1949cf8c6b5b557f\aws-lc-sys-0.35.0\aws-lc\third_party\jitterentropy\jitterentropy-library"
$env:CL = "/I`"$JITTER`""
build-cargo-package ${env:PKG_NAME}
