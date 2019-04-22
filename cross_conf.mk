ifeq ($(arch), raspbian)
CROSS_RASPBIAN:=$(arch)
	#raspbian OS
#	echo "Set Cross compiler to arm-linux-gnu-g++-6"
	CC = arm-linux-gnueabihf-g++-6
	LD = arm-linux-gnueabihf-g++-6
else ifeq ($(arch), rk3399)
CROSS_RK3399:=$(arch)
	#RK3399 debian
#	echo "Set Cross compiler to aarch64-linux-gnu-g++"
	CC = aarch64-linux-gnu-g++
	LD = aarch64-linux-gnu-g++
else
#	echo "Set Cross compiler to internal G++"
	CC = g++
	LD = g++
endif
TOPDIR=$(shell pwd)..
ifdef CROSS_RASPBIAN
ROOTFS=$(TOPDIR)/../rootfs/raspbian
BOOST_LIB_PATH = -L$(ROOTFS)/usr/lib/arm-linux-gnueabihf
BOOST_INC_PATH = -I$(ROOTFS)/usr/include
#CFLAGS_OPENCV_CROSS = -Wl,-rpath,$(TOPDIR)/../root_raspbian/lib/arm-linux-gnueabihf
CFLAGS_OPENCV_CROSS = -Wl,-rpath,$(ROOTFS)/lib/arm-linux-gnueabihf
CFLAGS_OPENCV_CROSS = -Wl,-rpath,$(ROOTFS)/usr/lib/arm-linux-gnueabihf
CFLAGS_OPENCV_CROSS += --sysroot=$(ROOTFS)
#CFLAGS_OPENCV_CROSS += --libdir=$(ROOTFS)/usr/lib
endif

ifdef CROSS_RK3399
ROOTFS=$(TOPDIR)/../rootfs/rk3399
BOOST_LIB_PATH = -L$(ROOTFS)/usr/lib/arm-linux-gnueabihf
BOOST_INC_PATH = -I$(ROOTFS)/usr/include
#
CFLAGS_OPENCV_CROSS = -Wl,-rpath,$(ROOTFS)/usr/lib/aarch64-linux-gnu
CFLAGS_OPENCV_CROSS += -Wl,-rpath,$(ROOTFS)/usr/lib/aarch64-linux-gnu/mesa
CFLAGS_OPENCV_CROSS += -Wl,-rpath,$(ROOTFS)/lib/aarch64-linux-gnu
CFLAGS_OPENCV_CROSS += -Wl,-rpath,$(ROOTFS)/libetc
CFLAGS_OPENCV_CROSS += --sysroot=$(ROOTFS)

endif


