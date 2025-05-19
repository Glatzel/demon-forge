New-Item $env:PREFIX/bin/oiiotool -ItemType Directory

if ($IsWindows) {
    Copy-Item "$env:RECIPE_DIR/../oiiotool_build/installed/x64-windows-static/tools/openimageio/*" "$env:PREFIX/bin/oiiotool"
}
if ($IsLinux) {
    Copy-Item "$env:RECIPE_DIR/../oiiotool_build/installed/x64-linux-release/tools/openimageio/*" "$env:PREFIX/bin/oiiotool"
}
if ($IsMacOS) {
    Copy-Item "$env:RECIPE_DIR/../oiiotool_build/installed/arm64-osx-release/tools/openimageio/*" "$env:PREFIX/bin/oiiotool"
}
