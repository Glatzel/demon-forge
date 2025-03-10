Set-Location $PSScriptRoot
Set-Location ..
New-Item ./oiio_dep/ocio -ItemType Directory -ErrorAction SilentlyContinue
$vcpkg = Resolve-Path ./ocio_dep/vcpkg_installed/x64-windows-static
$install_prefix=Resolve-Path ./oiio_dep/ocio

Set-Location ./external/OpenColorIO
Write-Output "::group::Make ocio"
Remove-Item */CMakeCache.txt -ErrorAction SilentlyContinue
cmake -S . -B build `
    -DCMAKE_BUILD_TYPE=Release `
    -DOpenImageIO_ROOT="$vcpkg" `
    -DYAML-CPP_ROOT="$vcpkg" `
    -DZLIB_ROOT="$vcpkg" `
    -DOCIO_BUILD_APPS=OFF `
    -DOCIO_BUILD_NUKE=OFF `
    -DOCIO_BUILD_DOCS=OFF `
    -DOCIO_BUILD_TESTS=OFF `
    -DOCIO_BUILD_GPU_TESTS=OFF `
    -DOCIO_BUILD_PYTHON=OFF `
    -DOCIO_BUILD_PYGLUE=OFF `
    -DOCIO_BUILD_JAVA=OFF `
    -DBUILD_SHARED_LIBS=ON `
    -DCMAKE_INSTALL_PREFIX="$install_prefix"
Write-Output "::endgroup::"

Write-Output "::group::build ocio"
cmake --build build --config Release --target install
Write-Output "::endgroup::"
