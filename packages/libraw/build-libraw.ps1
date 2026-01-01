Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsWindows) {
    $env:CMAKE_GENERATOR = "Visual Studio 17 2022"
    $env:CMAKE_GENERATOR_PLATFORM = "x64"
    $env:CMAKE_GENERATOR_TOOLSET = "v143"
    $env:CMAKE_INSTALL_PREFIX = "$env:PREFIX/Library"
}
if ($IsMacOS) {
    $env:CMAKE_INSTALL_PREFIX = "$env:PREFIX"
}
if ($IsLinux) {
    $env:CMAKE_INSTALL_PREFIX = "$env:PREFIX"
}
$version = get-current-version
Set-Location $ROOT/temp/$name
git clone https://github.com/LibRaw/LibRaw.git
git clone --depth 1 https://github.com/LibRaw/LibRaw-cmake.git
Set-Location LibRaw
git checkout tags/$version -b "branch-$version"
Copy-Item ../LibRaw-cmake/* ./ -Recurse
mkdir build
Set-Location build
cmake -DCMAKE_BUILD_TYPE="RELEASE" ..
cmake --build . --config Release --target install
