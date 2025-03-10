Set-Location $PSScriptRoot
Set-Location ..

$oiio_dep=Resolve-Path ./oiio_dep/vcpkg_installed/x64-windows-static
$oiio_dep = "$oiio_dep" -replace "\\", "/"

Write-Output "::group::Make oiio"
Set-Location ./external/OpenImageIO
# remove makecache
Remove-Item */CMakeCache.txt -ErrorAction SilentlyContinue
# make
cmake -S . -B build -DVERBOSE=ON -DCMAKE_BUILD_TYPE=Release `
  -DBUILD_DOCS=0 `
  -DBUILD_SHARED_LIBS=0 `
  -DBZip2_ROOT="$oiio_dep" `
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
  -Dfmt_ROOT="$oiio_dep" `
  -DFreetype_ROOT="$oiio_dep" `
  -DGIF_ROOT="$oiio_dep" `
  -DImath_ROOT="$oiio_dep" `
  -DINSTALL_DOCS=0 `
  -DJXL_ROOT="$oiio_dep" `
  -DLibheif_ROOT="$oiio_dep" `
  -Dlibjpeg-turbo_ROOT="$oiio_dep" `
  -DLibRaw_ROOT="$oiio_dep" `
  -DLINKSTATIC=1 `
  -DOIIO_BUILD_TESTS=0 `
  -DOpenColorIO_ROOT="$oiio_dep" `
  -DOpenEXR_ROOT="$oiio_dep" `
  -DOpenJPEG_ROOT="$oiio_dep" `
  -DPNG_ROOT="$oiio_dep" `
  -DTBB_ROOT="$oiio_dep" `
  -DTIFF_ROOT="$oiio_dep" `
  -DUSE_PYTHON=0 `
  -DUSE_QT=0 `
  -DUSE_SIMD="sse4.2,avx2" `
  -DWebP_ROOT="$oiio_dep" `
  -DZLIB_ROOT="$oiio_dep" `
  -DCMAKE_INSTALL_PREFIX="../../dist"
Write-Output "::endgroup::"

Write-Output "::group::build oiio"
cmake --build build --config Release --target install
Write-Output "::endgroup::"
