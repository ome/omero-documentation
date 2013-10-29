#
# MAKEFILE:
#
# Where the OMERO distribution was installed
OMERO_DIST ?= /opt/omero

# Where the Ice lib/ and include/ directories are to be found
ICE_HOME ?= /usr/share/Ice

INCLUDES=-I$(OMERO_DIST)/include -I$(ICE_HOME)/include 

LIBS = -L$(OMERO_DIST)/lib -L$(ICE_HOME)/lib -L$(ICE_HOME)/lib64 \
       -lIce -lIceUtil -lGlacier2 -lomero-client

LIBPATH = $(LD_LIBRARY_PATH):$(ICE_HOME)/lib:$(ICE_HOME)/lib64:$(OMERO_DIST)/lib

.PHONY: clean run

yourcode.o: yourcode.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $< $(INCLUDES)

yourcode: yourcode.o
	$(CXX) -o $@ $^ $(LIBS)

run:  yourcode
	LD_LIBRARY_PATH="$(LIBPATH)" ./yourcode --Ice.Config=../etc/ice.config

clean:
	rm -f yourcode *.o *~ core
