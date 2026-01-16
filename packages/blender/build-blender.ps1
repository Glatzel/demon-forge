$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$version = get-current-version
$version = [Version]"$version"
$major = $version.Major
$minor = $version.Minor
aria2c -c -x16 -s16 -d ./ `
    https://download.blender.org/release/Blender${major}.${minor}/blender-${version}-windows-x64.zip `
    -o "$name.zip"
7z x "./$name.zip" "-o./$name"
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "./$name/$name*/*" "$env:PREFIX/bin/$name" -Recurse
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
