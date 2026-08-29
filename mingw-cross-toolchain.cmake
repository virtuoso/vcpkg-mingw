set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

set(CMAKE_C_COMPILER_FRONTEND_VARIANT "GNU")
set(CMAKE_CXX_COMPILER_FRONTEND_VARIANT "GNU")

set(CMAKE_C_COMPILER_ID "GNU")
set(CMAKE_CXX_COMPILER_ID "GNU")

set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)
set(CMAKE_C_COMPILER_FORCED 1)
set(CMAKE_CXX_COMPILER_FORCED 1)

set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE static)
set(VCPKG_LIBRARY_LINKAGE static)

if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")
    set(CMAKE_C_COMPILER "C:/mingw64/bin/gcc.exe")
    set(CMAKE_CXX_COMPILER "C:/mingw64/bin/g++.exe")
    set(CMAKE_RC_COMPILER "C:/mingw64/bin/windres.exe")
else()
    set(CMAKE_C_COMPILER x86_64-w64-mingw32-gcc)
    set(CMAKE_CXX_COMPILER x86_64-w64-mingw32-g++)
    set(CMAKE_RC_COMPILER x86_64-w64-mingw32-windres)

    # vcpkg.cmake chainloads this file and only afterwards prepends the
    # installed tree to CMAKE_FIND_ROOT_PATH. CMake includes the toolchain
    # several times and on every re-inclusion vcpkg.cmake bails out early
    # (VCPKG_TOOLCHAIN is set by then), so overwriting the variable here
    # drops those entries; with the ONLY modes below that leaves every
    # find_path()/find_library() re-rooted under the sysroot alone and
    # nothing in installed/${VCPKG_TARGET_TRIPLET} is ever found.
    foreach(dir /usr/x86_64-w64-mingw32 /usr/lib/gcc/x86_64-w64-mingw32)
        if(NOT "${dir}" IN_LIST CMAKE_FIND_ROOT_PATH)
            list(APPEND CMAKE_FIND_ROOT_PATH "${dir}")
        endif()
    endforeach()

    set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
    set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
    set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
endif()

set(CMAKE_PREFIX_PATH "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/share/brotli" ${CMAKE_PREFIX_PATH})

# Switch library path based on build type
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(_VCPKG_LIB_DIR "debug/lib")
else()
    set(_VCPKG_LIB_DIR "lib")
endif()

# Set expected library search paths
set(CMAKE_LIBRARY_PATH "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/${_VCPKG_LIB_DIR}" ${CMAKE_LIBRARY_PATH})
set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")  # Disable .lib/.so probing

