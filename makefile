CC= gcc
LIB_HOME=src
LIBS = -lm
INCLUDE = -Isrc
OPT = #-std=c++14 -O3

DTYPE = 2
TIMES = 3
UPTO = 15
MAIN = matrix_multiplication.c


BUILDDIR :=obj
TARGETDIR :=bin

all:$(TARGETDIR)/runnable_${DTYPE}

debug:OPT += -DDEBUG -g

debug:NVCC_FLAG += -G
debug:all


OBJECTS=$(BUILDDIR)/my_library.o

$(TARGETDIR)/runnable_${DTYPE}: ${MAIN} $(OBJECTS)
	@mkdir -p $(@D)
	$(CC) $^ -o $@ $(INCLUDE) $(LIBS) $(OPT) -D DTYPE_code=$(DTYPE)
	
$(BUILDDIR)/my_library.o: src/my_library.c
	mkdir -p $(BUILDDIR) $(TARGETDIR)
	$(CC) -c -o $@ $(LIBS) $(INCLUDE) src/my_library.c $(OPT)


clean:
	rm $(BUILDDIR)/*.o $(TARGETDIR)/*
#	rm -t $(TARGETDIR)
