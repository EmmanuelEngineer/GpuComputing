CC= gcc
LIB_HOME=src
LIBS = -lm
INCLUDE = -Isrc
OPT = -O
OPT_NUM = 0
DTYPE = 2
TIMES = 3
UPTO = 15
MAIN = matrix_transposition.c
BLOCK = 0


BUILDDIR :=obj
TARGETDIR :=bin

all:$(TARGETDIR)/runnable_${DTYPE}

debug:OPT += -DDEBUG -g

debug:NVCC_FLAG += -G
debug:all


OBJECTS=$(BUILDDIR)/my_library.o

$(TARGETDIR)/runnable_${DTYPE}: ${MAIN} $(OBJECTS)
	@mkdir -p $(@D)
	$(CC) $^ -o $@ $(INCLUDE) $(LIBS) $(OPT)$(OPT_NUM) -D DTYPE_code=$(DTYPE) -D BLOCK=$(BLOCK)
	
$(BUILDDIR)/my_library.o: src/my_library.c
	mkdir -p $(BUILDDIR) $(TARGETDIR)
	$(CC) -c -o $@ $(LIBS) $(OPT)$(OPT_NUM) $(INCLUDE) src/my_library.c 


clean:
	rm $(BUILDDIR)/*.o $(TARGETDIR)/*
#	rm -t $(TARGETDIR)
