##
## Author: Hank Anderson <hank@statease.com>
## Copyright: (c) Stat-Ease, Inc.
## Created: 12/29/14
## Last Modified: 12/29/14
## Description: Ported from the OpenBLAS/c_check perl script.
##              This is triggered by prebuild.cmake and runs before any of the code is built.
##              Creates config.h and Makefile.conf.

# N.B. c_check is not cross-platform, so instead try to use CMake variables. Alternatively, could use try_compile to get some of this info the same way c_check does.

# run c_check (creates the TARGET files)
# message(STATUS "Running c_check...")
# execute_process(COMMAND perl c_check ${TARGET_MAKE} ${TARGET_CONF} ${CMAKE_CXX_COMPILER}
#    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})

# TODO: is ${BINARY} sufficient for the __32BIT__ define?
# TODO: CMAKE_SYSTEM_PROCESSOR is not set by CMake, need to set it manually when doing a cross-compile
# TODO: CMAKE_CXX_COMPILER_ID and CMAKE_SYSTEM_NAME are probably not the same strings as OpenBLAS is expecting
# TODO: detect NEED_FU
set(NEED_FU 1)

# Convert CMake vars into the format that OpenBLAS expects
string(TOUPPER ${CMAKE_SYSTEM_NAME} HOST_OS)
set(HOST_ARCH ${CMAKE_SYSTEM_PROCESSOR})
if (${HOST_ARCH} STREQUAL "AMD64")
  set(HOST_ARCH "X86_64")
endif ()

file(WRITE ${TARGET_CONF}
  "#define OS_${HOST_OS}\t1\n"
  "#define ARCH_${HOST_ARCH}\t1\n"
  "#define C_${CMAKE_CXX_COMPILER_ID}\t1\n"
  "#define __${BINARY}BIT__\t1\n"
  "#define FUNDERSCORE\t${NEED_FU}\n")
