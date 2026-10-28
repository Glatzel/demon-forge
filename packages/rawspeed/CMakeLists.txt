cmake_minimum_required(VERSION 3.20)
project(rawspeed-install LANGUAGES CXX)

set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
set(BUILD_TOOLS OFF CACHE BOOL "" FORCE)
set(BUILD_BENCHMARKING OFF CACHE BOOL "" FORCE)
set(BUILD_FUZZERS OFF CACHE BOOL "" FORCE)
set(BUILD_DOCS OFF CACHE BOOL "" FORCE)

add_subdirectory(rawspeed EXCLUDE_FROM_ALL)

include(GNUInstallDirs)
install(TARGETS rawspeed ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

# source headers
install(DIRECTORY rawspeed/src/librawspeed/
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/rawspeed
        FILES_MATCHING PATTERN "*.h")

# generated config header (location may vary by version, so check your build tree)
install(DIRECTORY ${CMAKE_BINARY_DIR}/rawspeed/src/
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/rawspeed
        FILES_MATCHING PATTERN "rawspeedconfig.h")
