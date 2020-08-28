#
# CMake Toolchain file for crosscompiling on ARM.
#
# This can be used when running cmake in the following way:
#  cd build/
#  cmake .. -DCMAKE_TOOLCHAIN_FILE=../cross-arm-linux-gnueabihf.cmake
#

# Target operating system name.
set(CMAKE_SYSTEM_NAME Linux)
## temp
set(CROSS_PATH "/opt/hisi-linux/x86-arm/arm-himix100-linux")

## temp
#set(LWS_HAVE_EVENTFD 0)
#set(BUILD_OPENSSL ON)
#set(BUILD_OPENSSL_PLATFORM linux-generic32)

set(BUILD_LIBSRTP_HOST_PLATFORM x86_64-unknown-linux-gnu)
set(BUILD_LIBSRTP_DESTINATION_PLATFORM arm-unknown-linux-uclibcgnueabi)

# Name of C compiler.
set(CMAKE_C_COMPILER    "${CROSS_PATH}/bin/arm-himix100-linux-gcc")
set(CMAKE_CXX_COMPILER  "${CROSS_PATH}/bin/arm-himix100-linux-g++")
set(CMAKE_AR            "${CROSS_PATH}/bin/arm-himix100-linux-ar")
set(CMAKE_RANLIB        "${CROSS_PATH}/bin/arm-himix100-linux-ranlib")
set(CMAKE_LINKER        "${CROSS_PATH}/bin/arm-himix100-linux-ld")

#
# Different build system distros set release optimization level to different
# things according to their local policy, eg, Fedora is -O2 and Ubuntu is -O3
# here.  Actually the build system's local policy is completely unrelated to
# our desire for cross-build release optimization policy for code built to run
# on a completely different target than the build system itself.
#
# Since this goes last on the compiler commandline we have to override it to a
# sane value for cross-build here.  Notice some gcc versions enable broken
# optimizations with -O3.
#
#if (CMAKE_BUILD_TYPE MATCHES RELEASE OR CMAKE_BUILD_TYPE MATCHES Release OR CMAKE_BUILD_TYPE MATCHES release)
#	set(CMAKE_C_FLAGS_RELEASE ${CMAKE_C_FLAGS_RELEASE} -O2)
#	set(CMAKE_CXX_FLAGS_RELEASE ${CMAKE_CXX_FLAGS_RELEASE} -O2)
#endif()

add_definitions(-fgnu89-inline)
add_definitions(-Wno-pointer-to-int-cast)
add_definitions(-Wno-int-to-pointer-cast)
add_definitions(-Wno-implicit-function-declaration)
add_definitions(-Wno-unused-value)
add_definitions(-Wno-incompatible-pointer-types)
add_definitions(-Wno-unused-variable)
add_definitions(-Wno-unused-but-set-variable)
add_definitions(-fno-tree-scev-cprop)
add_definitions(-Wno-strict-prototypes)
add_definitions(-Wno-strict-aliasing)
add_definitions(-Wno-variadic-macros)
add_definitions(-Wno-pedantic)


message(status, "CMAKE_C_FLAGS===${CMAKE_C_FLAGS}")

SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -nostdlib -Wall -Werror")

##/home/iotlab/scofield/_workspace/rtos-porting/hi3518-sdk/osdrv/platform/liteos/liteos
SET(TOOLCHAIN_ENV_ROOT "/home/iotlab/scofield/_workspace/rtos-porting")
SET(OSDRV_DIR       "${TOOLCHAIN_ENV_ROOT}/hi3518-sdk/osdrv")
SET(LITEOSTOPDIR    "${OSDRV_DIR}/platform/liteos/liteos")
SET(RTOS_DIR        "${LITEOSTOPDIR}")

#ifeq ($(LOSCFG_COMPAT_POSIX), y)
#    LITEOS_BASELIB += -lposix
#    LIB_SUBDIRS       += compat/posix
#    LITEOS_POSIX_INCLUDE   += \
#        -I $(LITEOSTOPDIR)/compat/posix/include
#endif

#ifeq ($(LOSCFG_COMPAT_LINUX), y)
#    LITEOS_BASELIB += -llinux
#    LIB_SUBDIRS       += compat/linux
#    LITEOS_LINUX_INCLUDE   += -I $(LITEOSTOPDIR)/compat/linux/include
#endif

#include_directories(${LITEOSTOPDIR}/compat/posix/include)
#include_directories(${LITEOSTOPDIR}/compat/posix/include)
#include_directories(${LITEOSTOPDIR}/lib/libc)
#include_directories(${LITEOSTOPDIR}/lib/libm)
#include_directories(${LITEOSTOPDIR}/compat/linux/include)
#link_directories(${LITEOSTOPDIR}/out)

# Where to look for the target environment. (More paths can be added here)
#set(CMAKE_FIND_ROOT_PATH "/opt/hisi-linux/x86-arm/arm-himix100-linux" "${LITEOSTOPDIR}" "${TOOLCHAIN_ENV_ROOT}/kvs-webrtc-mbedtls/open-source")
set(CMAKE_FIND_ROOT_PATH "/opt/hisi-linux/x86-arm/arm-himix100-linux" "${LITEOSTOPDIR}")

# Adjust the default behavior of the FIND_XXX() commands:
# search programs in the host environment only.
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# Search headers and libraries in the target environment only.
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

