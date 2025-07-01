Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

aria2c -c -x16 -s16 `
    -d $ROOT/temp/$name `
    https://www.passmark.com/downloads/PerformanceTest_Linux_ARM64.zip `
    -o passmark.zip
7z e ./temp/passmark.zip PerformanceTest/pt_linux_arm64 -o$ROOT/temp/$name

pixi run rattler-build build --target-platform linux-aarch64
