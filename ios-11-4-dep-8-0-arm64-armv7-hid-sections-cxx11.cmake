# Copyright (c) 2017-2018, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_IOS_11_4_DEP_8_0_ARM64_ARMV7_HID_SECTIONS_CXX11_CMAKE_)
  return()
else()
  set(POLLY_IOS_11_4_DEP_8_0_ARM64_ARMV7_HID_SECTIONS_CXX11_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(IOS_SDK_VERSION 11.4)
set(IOS_DEPLOYMENT_SDK_VERSION 8.0)

set(POLLY_XCODE_COMPILER "clang")
polly_init(
    "iOS ${IOS_SDK_VERSION} / Deployment ${IOS_DEPLOYMENT_SDK_VERSION} / Universal (arm64 armv7) / \
${POLLY_XCODE_COMPILER} / \
c++11 support / hidden / data-sections / function-sections "
    "Xcode"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include(polly_fatal_error)

######### TINY MODE ##########
SET( CMAKE_CXX_FLAGS_TINY "-Oz" CACHE STRING
    "Flags used by the C++ compiler during tiny builds."
    FORCE )
SET( CMAKE_C_FLAGS_TINY "-Oz" CACHE STRING
    "Flags used by the C compiler during tiny builds."
    FORCE )
SET( CMAKE_EXE_LINKER_FLAGS_TINY
    "${CMAKE_EXE_LINKER_FLAGS_MINSIZEREL}" CACHE STRING
    "Flags used for linking binaries during tiny builds."
    FORCE )
SET( CMAKE_SHARED_LINKER_FLAGS_TINY
    "${CMAKE_SHARED_LINKER_FLAGS_MINSIZEREL}" CACHE STRING
    "Flags used by the shared libraries linker during tiny builds."
    FORCE )
MARK_AS_ADVANCED(
    CMAKE_CXX_FLAGS_TINY
    CMAKE_C_FLAGS_TINY
    CMAKE_EXE_LINKER_FLAGS_TINY
    CMAKE_SHARED_LINKER_FLAGS_TINY )
# Update the documentation string of CMAKE_BUILD_TYPE for GUIs
SET( CMAKE_BUILD_TYPE "${CMAKE_BUILD_TYPE}" CACHE STRING
    "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel Tiny."
    FORCE )
######### TINY MODE ##########

# Fix try_compile
include(polly_ios_bundle_identifier)

set(CMAKE_MACOSX_BUNDLE YES)
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer")

set(IPHONEOS_ARCHS arm64;armv7)
set(IPHONESIMULATOR_ARCHS "")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/xcode.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/iphone.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/hidden.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/function-sections.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/data-sections.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_ios_development_team.cmake")
