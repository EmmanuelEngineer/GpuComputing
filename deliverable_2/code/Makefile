CC= nvcc
LIB_HOME=src
LIBS = -lm
INCLUDE = -Isrc
OPT = -O
OPT_NUM = 0
DTYPE = 1
UPTO = 15
MAIN = src/MatrixTrasposition.cu
TILE_DIM = 32
BLOCK_ROWS = 8
NUM_REPS = 100

BUILDDIR :=obj
TARGETDIR :=bin

all:$(TARGETDIR)/runnable_${DTYPE}

debug:DEBUG += -DDEBUG -g

debug:NVCC_FLAG += -G
debug:all


$(TARGETDIR)/runnable_${DTYPE}:
	@mkdir -p $(@D)
	$(CC) ${MAIN} -o $@ $(INCLUDE) $(LIBS) $(OPT)$(OPT_NUM)  -D DTYPE_code=$(DTYPE) -D TILE_DIM=$(TILE_DIM) -D BLOCK_ROWS=$(BLOCK_ROWS) -D NUM_REPS=$(NUM_REPS)
	
clean:
	rm $(BUILDDIR)/*.o $(TARGETDIR)/*
#	rm -t $(TARGETDIR)
