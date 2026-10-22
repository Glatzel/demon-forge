cmake_args="
-DBUILD_DOCS=0
-DBUILD_SHARED_LIBS=1
-DENABLE_INSTALL_testtex=0
-DENABLE_DCMTK=0
-DENABLE_libuhdr=0
-DENABLE_Nuke=0
-DENABLE_Ptex=0
-DENABLE_Python3=0
-DINSTALL_DOCS=0
-DLINKSTATIC=0
-DOIIO_BUILD_TESTS=0
-DUSE_PYTHON=0
-DUSE_QT=0
"

# Linux
if [ "$(uname)" = "Linux" ]; then
    if [ "$TARGET_PLATFORM" = "linux-64" ]; then
        cmake_args="$cmake_args -DUSE_SIMD=sse4.2,avx2"
    fi
fi

cmake_build $cmake_args
