Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-url -url "https://nssm.cc/download" -pattern 'nssm (\d+\.\d+)'
update-recipe -version $latest_version

aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    "https://nssm.cc/release/nssm-$latest_version.zip" `
    -o "$name.zip"

7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"

build-pkg
