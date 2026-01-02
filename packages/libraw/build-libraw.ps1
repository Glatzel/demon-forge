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
if ($env:DIST_BUILD) {$env:DCMAKE_BUILD_TYPE="RELEASE"}
git clone --depth 1 https://github.com/LibRaw/LibRaw-cmake.git
Copy-Item ./LibRaw-cmake/* ./ -Recurse
mkdir build
Set-Location build
cmake ..
if ($env:DIST_BUILD) {
    cmake --build . --config Release --target install
}
else{
    cmake --build . --target install
}
