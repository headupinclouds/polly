#
# Clang compiler on OSX toolchain
#
# (c) Copyrights 2009-2011 Hartmut Seichter
# 
# Note: using LLVM as a "cross compiler"
#

if(DEFINED POLLY_LLVM_OSX_LINUX_CMAKE_)
  return()
else()
  set(POLLY_LLVM_OSX_LINUX_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

#https://github.com/seichter/CMake-Toolchain-Collection/blob/master/toolchain-llvm-osx.cmake

# http://llvm.org/docs/HowToCrossCompileLLVM.html
# -DCMAKE_CROSSCOMPILING=True
# -DCMAKE_INSTALL_PREFIX=<install-dir>
# -DLLVM_TABLEGEN=<path-to-host-bin>/llvm-tblgen
# -DCLANG_TABLEGEN=<path-to-host-bin>/clang-tblgen
# -DLLVM_DEFAULT_TARGET_TRIPLE=arm-linux-gnueabihf
# -DLLVM_TARGET_ARCH=ARM
# -DLLVM_TARGETS_TO_BUILD=ARM
# -DCMAKE_CXX_FLAGS='-target armv7a-linux-gnueabihf -mcpu=cortex-a9 -I/usr/arm-linux-gnueabihf/include/c++/4.7.2/arm-linux-gnueabihf/ -I/usr/arm-linux-gnueabihf/include/ -mfloat-abi=hard -ccc-gcc-name arm-linux-gnueabihf-gcc'

polly_init(
    "Linux / llvm / c++11 support"
    "Unix Makefiles"
)

include(CMakeForceCompiler)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)

#set(LLVM_PATH $ENV{LLVM_ROOT} CACHE STRING "Native Client SDK Root Path")

set(LLVM_HOST)
set(LLVM_TAG LLVM)

# Use macports path
#set(LLVM_PATH /opt/local)

# Use default path
set(LLVM_PATH /usr)

# 
# Basic settings
# 
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)

set(CMAKE_FIND_ROOT_PATH
	${LLVM_PATH}/include
	${LLVM_PATH}/usr/include
	)

set(CMAKE_C_COMPILER   ${LLVM_PATH}/bin/clang)
set(CMAKE_CXX_COMPILER ${LLVM_PATH}/bin/clang++)
set(CMAKE_ASM_COMPILER ${LLVM_PATH}/bin/${LLVM_TAG}-as)

set(CMAKE_CROSSCOMPILING True)

set(TOOLCHAIN_LLVM_DEBUG 1)

if(TOOLCHAIN_LLVM_DEBUG)
	message(STATUS "${CMAKE_C_COMPILER}")
endif()

set(CMAKE_C_FLAGS 
	CACHE STRING "LLVM - GCC/C flags" FORCE
)

set(CMAKE_CXX_FLAGS 
	""
	CACHE STRING "LLVM - GCC/C++ flags" FORCE
)

set(CMAKE_SHARED_LINKER_FLAGS 
	""
	CACHE STRING "LLVM - GCC/C++ flags" FORCE
)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
