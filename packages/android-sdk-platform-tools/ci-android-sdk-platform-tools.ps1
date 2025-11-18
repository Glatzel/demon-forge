Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-url -url "https://developer.android.com/tools/releases/platform-tools" -pattern '([0-9]+\.[0-9]+\.[0-9]+)'
update-recipe -version $latest_version

aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    "https://googledownloads.cn/android/repository/platform-tools-latest-windows.zip" `
    -o "$name.zip"
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name"
build-pkg
