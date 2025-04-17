if(NOT TARGET Brotli::dec)
    add_library(Brotli::dec STATIC IMPORTED GLOBAL)
    set_target_properties(Brotli::dec PROPERTIES
        IMPORTED_LOCATION "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib/libbrotlidec.a;${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib/libbrotlicommon.a"
        INTERFACE_INCLUDE_DIRECTORIES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include"
    )
endif()

