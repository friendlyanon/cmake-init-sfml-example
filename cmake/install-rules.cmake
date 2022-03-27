include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package sfml-example)

install(
    TARGETS sfml-example_exe
    RUNTIME COMPONENT sfml-example_Runtime
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    sfml-example_INSTALL_CMAKEDIR "${CMAKE_INSTALL_DATADIR}/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(sfml-example_INSTALL_CMAKEDIR)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${sfml-example_INSTALL_CMAKEDIR}"
    COMPONENT sfml-example_Development
)

# Export variables for the install script to use
install(CODE "
set(sfml-example_NAME [[$<TARGET_FILE_NAME:sfml-example_exe>]])
set(sfml-example_INSTALL_CMAKEDIR [[${sfml-example_INSTALL_CMAKEDIR}]])
set(CMAKE_INSTALL_BINDIR [[${CMAKE_INSTALL_BINDIR}]])
" COMPONENT sfml-example_Development)

install(
    SCRIPT cmake/install-script.cmake
    COMPONENT sfml-example_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
