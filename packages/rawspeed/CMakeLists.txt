cmake_minimum_required(VERSION 3.20)
project(rawspeed-install LANGUAGES CXX)

include(GNUInstallDirs)

# rawspeed options: only build the library
set(BUILD_TESTING      OFF CACHE BOOL "" FORCE)
set(BUILD_TOOLS        OFF CACHE BOOL "" FORCE)
set(BUILD_BENCHMARKING OFF CACHE BOOL "" FORCE)
set(BUILD_FUZZERS      OFF CACHE BOOL "" FORCE)
set(BUILD_DOCS         OFF CACHE BOOL "" FORCE)

# No EXCLUDE_FROM_ALL, so `--target install` builds it first
add_subdirectory(rawspeed)

# Library (static or shared, whichever BUILD_SHARED_LIBS selects)
install(TARGETS rawspeed
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

# Public headers, keeping the librawspeed/ directory structure
install(DIRECTORY rawspeed/src/librawspeed/
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/rawspeed
        FILES_MATCHING PATTERN "*.h")

# Generated config header (lives in the build tree)
install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/rawspeed/src/
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/rawspeed
        FILES_MATCHING PATTERN "rawspeedconfig.h")

# Camera database, needed at runtime
install(FILES rawspeed/data/cameras.xml
        DESTINATION ${CMAKE_INSTALL_DATADIR}/rawspeed)
