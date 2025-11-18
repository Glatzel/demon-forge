Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-url -url "https://www.passmark.com/products/performancetest/download.php" -pattern 'Download PerformanceTest (\d+\.\d+)'
update-recipe -version $latest_version

aria2c -c -x16 -s16 `
    -d $ROOT/temp/$name `
    https://www.passmark.com/downloads/PerformanceTest_Linux_ARM64.zip `
    -o passmark.zip
7z e $ROOT/temp/$name/passmark.zip PerformanceTest/pt_linux_arm64 -o$ROOT/temp/$name

pixi run rattler-build build --target-platform linux-aarch64
