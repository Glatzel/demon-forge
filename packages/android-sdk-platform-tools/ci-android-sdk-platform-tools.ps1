Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name
Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    "https://googledownloads.cn/android/repository/platform-tools-latest-windows.zip" `
    -o "$name.zip"
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name"
$output = & $ROOT/temp/$name/platform-tools/adb.exe version
"$output" -match 'Version (\S+)-\S+'
$version = $Matches[1]
update-recipe -version $version
build-pkg
