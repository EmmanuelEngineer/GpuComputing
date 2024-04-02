CC= C++
LIB_HOME=-----
LIBS = -std=c++14 -03 -lm

MAIN = src/matrix_mutiplication.c


BUILDDIR :=obj
TARGETDIR :=bin

all:$(TARGETDIR)/lab1

debug:OPT += -DDEBUG -g

debug:NVCC_FLAG += -G
debug:all

OBJECTS=$(BUILDDIR)/my_library.o

$(TARGETDIR)/lab1:${MAIN} $(OBJECTS)
	@mkdir -p $(@D)
	$(CC) $^ -o $@ $(INCLUDE) $(LIBS) $(OPT)

$(BUILDDIR)/my_library.o: src/my_Library.c
	mkdir -p $(BUILDDIR) $(TARGETDIR)
	$(CC) -c -o $@ $(LIBS) $(INCLUDE) src/my_library.c $(OPT)

clean:
	rm $(BUILDDIR)/*.o $(TARGETDIR)/*
#	rm -t $(TARGETDIR)
