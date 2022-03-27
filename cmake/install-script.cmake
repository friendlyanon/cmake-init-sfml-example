file(
    RELATIVE_PATH relative_path
    "/${sfml-example_INSTALL_CMAKEDIR}"
    "/${CMAKE_INSTALL_BINDIR}/${sfml-example_NAME}"
)

get_filename_component(prefix "${CMAKE_INSTALL_PREFIX}" ABSOLUTE)
set(config_dir "${prefix}/${sfml-example_INSTALL_CMAKEDIR}")
set(config_file "${config_dir}/sfml-exampleConfig.cmake")

message(STATUS "Installing: ${config_file}")
file(WRITE "${config_file}" "\
get_filename_component(
    _sfml-example_executable
    \"\${CMAKE_CURRENT_LIST_DIR}/${relative_path}\"
    ABSOLUTE
)
set(
    SFML_EXAMPLE_EXECUTABLE \"\${_sfml-example_executable}\"
    CACHE FILEPATH \"Path to the sfml-example executable\"
)
")
