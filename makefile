-include cross_conf.mk
INC_BOOST = $(BOOST_INC_PATH)

INCDIR = -I. \
		 
SRCDIR = . \

VPATH = $(SRCDIR)

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:./../opencv_lib/3.4.2/lib/pkgconfig
#OPENCV = `pkg-config opencv_3.4.2 --cflags --libs`
BOOST = $(BOOST_LIB_PATH) -lboost_system -lboost_thread -lboost_filesystem -lstdc++
#BOOST = -L./../aarch64-linux-gnu -lboost_system -lboost_thread 
USERLIB = -lpthread
LIBS = $(OPENCV) $(BOOST) $(USERLIB)

#Ubuntu cross compile
CFLAGS = -O2 -g -Wall  $(INCDIR)
CFLAGS += $(CFLAGS_OPENCV_CROSS)
CFLAGS += -std=c++11

#CFLAGS = -O2 -g -Wall -std=gnu++11 $(INCDIR)
TARGET = testapp

SRCS = $(foreach dir, $(VPATH), $(wildcard $(dir)/*.cpp))
#SRCS := $(notdir $(SRCS))
#SRCS = CGCS_Server.cpp
#SRCS = client_test.cpp
SRCS := $(SRCS)

OBJS = $(SRCS:.cpp=.o)

all: $(TARGET)

$(TARGET):$(OBJS)
	$(LD) $^ $(CFLAGS) -o $(TARGET) $(LIBS)
#	mv $(TARGET) ../


.cpp.o:
	echo $(arch)
	$(CC) $(CFLAGS) -c $< -o $@

clean: 
	-rm -rf $(OBJS)
	-rm -f $(TARGET)
	-rm depend

depend: $(SRCS)
	$(CC) -M $(CFLAGS) $^ > $@

-include depend
