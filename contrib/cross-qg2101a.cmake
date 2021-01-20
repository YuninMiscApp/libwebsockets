#
# CMake Toolchain file for crosscompiling on ARM.
#
# This can be used when running cmake in the following way:
#  cd build/
#  cmake .. -DCMAKE_TOOLCHAIN_FILE=../cross-arm-linux-gnueabihf.cmake
#

# Target operating system name.
set(CMAKE_SYSTEM_NAME Linux)

# assumed these are set up on the $PATH
set(TC arm-melis-eabi)

set(CMAKE_C_COMPILER	"${TC}-gcc${EXECUTABLE_EXT}")
set(CMAKE_AR		"${TC}-ar${EXECUTABLE_EXT}")
set(CMAKE_RANLIB	"${TC}-ranlib${EXECUTABLE_EXT}")
set(CMAKE_LINKER	"${TC}-ld${EXECUTABLE_EXT}")
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")


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
if (CMAKE_BUILD_TYPE MATCHES RELEASE OR CMAKE_BUILD_TYPE MATCHES Release OR CMAKE_BUILD_TYPE MATCHES release)
	set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -O2")
	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O2")
endif()


set(QG2101A_ROOT /home/leon/work/aws-webrtc-plat-qg2101-rtos-sdk/RtosSdk-Pure/source)


SET(CMAKE_C_FLAGS "-nostdlib -Wall -undefined \
	-I${QG2101A_ROOT}/include \
	-I${QG2101A_ROOT}/include/melis \
	-I${QG2101A_ROOT}/ekernel/subsys/net/rt-thread/lwip/src/include/compat/posix \
	-I${QG2101A_ROOT}/include/melis/kernel \
	-I${QG2101A_ROOT}/include/melis/ipc \
	-I${QG2101A_ROOT}/ekernel/core/rt-thread/include \
	-I${QG2101A_ROOT}/ekernel/subsys \
	-I${QG2101A_ROOT}/ekernel/subsys/thirdparty/dfs/include \
	-I${QG2101A_ROOT}/ekernel/subsys/finsh_cli \
	-I${QG2101A_ROOT}/ekernel/subsys/net/rt-thread/lwip/src/include \
	-I${QG2101A_ROOT}/ekernel/subsys/net/rt-thread/lwip/src/arch/include \
	-I${QG2101A_ROOT}/ekernel/subsys/net/rt-thread/lwip/src \
	-I${QG2101A_ROOT}/ekernel/subsys/net/rt-thread/lwip/src/include/lwip \
	-I${QG2101A_ROOT}/ekernel/subsys/net/rt-thread/lwip/src/include/compat/posix \
	-I${QG2101A_ROOT}/ekernel/subsys/net/rt-thread/lwip/src/apps/mbedtls/include \
	-I${QG2101A_ROOT}/ekernel/core/rt-thread/include \
	-I${QG2101A_ROOT}/ekernel/subsys/thirdparty/dfs/include ")
#
#link_libraries(/home/leon/work/aws-webrtc-plat-qg2101-rtos-sdk/RtosSdk-Pure/source/ekernel/subsys/libc/newlib/built-in.o)

