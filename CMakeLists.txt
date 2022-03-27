cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    sfml-example
    VERSION 0.1.0
    DESCRIPTION "Short description"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    sfml-example_lib OBJECT
    source/lib.cpp
)

target_include_directories(
    sfml-example_lib ${warning_guard}
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/source>"
)

target_compile_features(sfml-example_lib PUBLIC cxx_std_17)

find_package(fmt REQUIRED)
target_link_libraries(sfml-example_lib PRIVATE fmt::fmt)

# ---- Declare executable ----

add_executable(sfml-example_exe source/main.cpp)
add_executable(sfml-example::exe ALIAS sfml-example_exe)

set_target_properties(
    sfml-example_exe PROPERTIES
    OUTPUT_NAME sfml-example
    EXPORT_NAME exe
)

target_compile_features(sfml-example_exe PRIVATE cxx_std_17)

# Note: not using OPTIONAL_COMPONENTS for the "main" component, because the
#       SFML config does not support optional component arguments. This
#       "works", but depends on the fact that the SFML config creates targets
#       whether they were requested or not.
find_package(SFML 2.5 REQUIRED COMPONENTS graphics)
target_link_libraries(sfml-example_exe PRIVATE sfml-example_lib sfml-graphics)
if(TARGET sfml-main)
  target_link_libraries(sfml-example_exe PRIVATE sfml-main)
endif()

# Note: SFML does not properly propagate its requirements and it requires
#       OpenGL in its install interface when compiled as a static library.
if(SFML_STATIC_LIBRARIES AND NOT IOS AND NOT WIN32)
  find_package(OpenGL REQUIRED)
  target_link_libraries(sfml-example_exe PRIVATE OpenGL::GL)
endif()

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT sfml-example_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of sfml-example"
  )
endif()

include(cmake/dev-mode.cmake)
