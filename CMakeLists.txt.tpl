cmake_minimum_required (VERSION 2.6)
project (${CMAKE_PROJECT_NAME})
# The version number.
set (${CMAKE_PROJECT_NAME}_VERSION_MAJOR 1)
set (${CMAKE_PROJECT_NAME}_VERSION_MINOR 0)
 
# configure a header file to pass some of the CMake settings
# to the source code
configure_file (
  "${PROJECT_SOURCE_DIR}/${CMAKE_PROJECT_NAME}_config.h.in"
  "${PROJECT_BINARY_DIR}/${CMAKE_PROJECT_NAME}_config.h"
  )
 
# add the binary tree to the search path for include files
# so that we will find ${CMAKE_PROJECT_NAME}_config.h
include_directories("${PROJECT_BINARY_DIR}")
 
# add the executable
add_executable(${CMAKE_PROJECT_NAME} main.cpp)
