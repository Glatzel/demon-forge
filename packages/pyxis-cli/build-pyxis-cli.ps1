New-Item $env:PREFIX/bin -ItemType Directory -ErrorAction SilentlyContinue
if ($env:DIST_BUILD) {
    $config = "release"
}
else {
    $config = "debug"
}
if ($IsWindows) {
    Copy-Item $PSScriptRoot/../target/$config/pyxis.exe "$env:PREFIX/bin/"
}
else {
    Copy-Item $PSScriptRoot/../target/$config/pyxis "$env:PREFIX/pyxis/bin/"
}
