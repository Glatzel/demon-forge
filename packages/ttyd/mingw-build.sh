#!/bin/bash

set -eo pipefail

build_libwebsockets() {
  cd external/libwebsockets
    makepkg-mingw --syncdeps --force --noconfirm
    pacman -U *.pkg.tar.zst --noconfirm
  cd ../..
}
pacman -S --noconfirm \
    base-devel \
    subversion \
    mingw-w64-ucrt-x86_64-gcc \
    mingw-w64-ucrt-x86_64-cmake \
    mingw-w64-ucrt-x86_64-zlib \
    mingw-w64-ucrt-x86_64-libuv \
    mingw-w64-ucrt-x86_64-mbedtls \
    mingw-w64-ucrt-x86_64-json-c
build_libwebsockets

# workaround for the lib name change
cp ${MINGW_PREFIX}/lib/libuv_a.a ${MINGW_PREFIX}/lib/libuv.a

rm -rf build && mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_FIND_LIBRARY_SUFFIXES=".a" \
    -DCMAKE_C_FLAGS="-Os -ffunction-sections -fdata-sections -fno-unwind-tables -fno-asynchronous-unwind-tables -flto" \
    -DCMAKE_EXE_LINKER_FLAGS="-static -no-pie -Wl,-s -Wl,-Bsymbolic -Wl,--gc-sections" \
    ..
cmake --build .
