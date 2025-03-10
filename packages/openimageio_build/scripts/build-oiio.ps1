Set-Location $PSScriptRoot
Set-Location ..

$ocio_root=Resolve-Path ./oiio_dep/ocio
$ocio_root = "$ocio_root" -replace "\\", "/"
$vcpkg_dep=Resolve-Path ./oiio_dep/vcpkg_installed/x64-windows-static
$vcpkg_dep = "$vcpkg_dep" -replace "\\", "/"

Write-Output "::group::Make oiio"
Set-Location ./external/OpenImageIO
# remove makecache
Remove-Item */CMakeCache.txt -ErrorAction SilentlyContinue
# make
cmake -S . -B build -DVERBOSE=ON -DCMAKE_BUILD_TYPE=Release `
  -DBUILD_DOCS=0 `
  -DBUILD_SHARED_LIBS=0 `
  -DBZip2_ROOT="$vcpkg_dep" `
  -DCMAKE_C_FLAGS="/utf-8" `
  -DCMAKE_CXX_FLAGS="/utf-8" `
  -DENABLE_DCMTK=0 `
  -DENABLE_FFmpeg=0 `
  -DENABLE_INSTALL_testtex=0 `
  -DENABLE_libuhdr=0 `
  -DENABLE_Nuke=0 `
  -DENABLE_OpenCV=0 `
  -DENABLE_OpenVDB=0 `
  -DENABLE_Ptex=0 `
  -DENABLE_Python3=0 `
  -Dfmt_ROOT="$vcpkg_dep" `
  -DFreetype_ROOT="$vcpkg_dep" `
  -DGIF_ROOT="$vcpkg_dep" `
  -DImath_ROOT="$vcpkg_dep" `
  -DINSTALL_DOCS=0 `
  -DJXL_ROOT="$vcpkg_dep" `
  -DLibheif_ROOT="$vcpkg_dep" `
  -Dlibjpeg-turbo_ROOT="$vcpkg_dep" `
  -DLibRaw_ROOT="$vcpkg_dep" `
  -DLINKSTATIC=1 `
  -DOIIO_BUILD_TESTS=0 `
  -DOpenColorIO_ROOT="$ocio_root" `
  -DOpenEXR_ROOT="$vcpkg_dep" `
  -DOpenJPEG_ROOT="$vcpkg_dep" `
  -DPNG_ROOT="$vcpkg_dep" `
  -DTBB_ROOT="$vcpkg_dep" `
  -DTIFF_ROOT="$vcpkg_dep" `
  -DUSE_PYTHON=0 `
  -DUSE_QT=0 `
  -DUSE_SIMD="sse4.2,avx2" `
  -DWebP_ROOT="$vcpkg_dep" `
  -DZLIB_ROOT="$vcpkg_dep" `
  -DCMAKE_INSTALL_PREFIX="../../dist"
Write-Output "::endgroup::"

Write-Output "::group::build oiio"
cmake --build build --config Release --target install
Write-Output "::endgroup::"
