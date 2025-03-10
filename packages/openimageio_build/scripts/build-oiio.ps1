Set-Location $PSScriptRoot
Set-Location ..

$conda_pkg=Resolve-Path ./.pixi/envs/oiio/Library
$conda_pkg = "$conda_pkg" -replace "\\", "/"

Write-Output "::group::Make oiio"
Set-Location ./external/OpenImageIO
# remove makecache
Remove-Item */CMakeCache.txt -ErrorAction SilentlyContinue
# make
cmake -S . -B build -DVERBOSE=ON -DCMAKE_BUILD_TYPE=Release `
  -DBUILD_DOCS=0 `
  -DBUILD_SHARED_LIBS=1 `
  -DBZip2_ROOT="$conda_pkg" `
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
  -Dfmt_ROOT="$conda_pkg" `
  -DFreetype_ROOT="$conda_pkg" `
  -DGIF_ROOT="$conda_pkg" `
  -DImath_ROOT="$conda_pkg" `
  -DINSTALL_DOCS=0 `
  -DJXL_ROOT="$conda_pkg" `
  -DLibheif_ROOT="$conda_pkg" `
  -Dlibjpeg-turbo_ROOT="$conda_pkg" `
  -DLibRaw_ROOT="$conda_pkg" `
  -DLINKSTATIC=0 `
  -DOIIO_BUILD_TESTS=0 `
  -DOpenColorIO_ROOT="$conda_pkg" `
  -DOpenEXR_ROOT="$conda_pkg" `
  -DOpenJPEG_ROOT="$conda_pkg" `
  -DPNG_ROOT="$conda_pkg" `
  -DTBB_ROOT="$conda_pkg" `
  -DTIFF_ROOT="$conda_pkg" `
  -DUSE_PYTHON=0 `
  -DUSE_QT=0 `
  -DUSE_SIMD="sse4.2,avx2" `
  -DWebP_ROOT="$conda_pkg" `
  -DZLIB_ROOT="$conda_pkg"
Write-Output "::endgroup::"

Write-Output "::group::build oiio"
cmake --build build --config Release --target install
Write-Output "::endgroup::"
