Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$repoUrl = "https://github.com/$name/$name.git"
$latestTag = git ls-remote --tags $repoUrl | Where-Object { $_ -match "refs/tags/v\d+.\d+.\d+" } | ForEach-Object { $_ -replace '^.*refs/tags/v(.*)$', '$1' }| Select-Object -Last 1
$latest_version = [Version]"$latestTag"
$major = $latest_version.Major
$minor = $latest_version.Minor
update-recipe -version $latest_version
create-temp -name $name
aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    https://download.blender.org/release/Blender${major}.${minor}/blender-$latest_version-windows-x64.zip `
    -o "$name.zip"
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name"

build-pkg
