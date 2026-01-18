$JITTER = Get-ChildItem "$env:BUILD_PREFIX\.cargo\registry\src\index.crates.io-*\" `
    -Recurse -Directory -Filter "jitterentropy-library" |
    Select-Object -First 1 -ExpandProperty FullName
write-output $JITTER
$env:CL = "/I`"$JITTER`""
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
build-cargo-package ${env:PKG_NAME}
