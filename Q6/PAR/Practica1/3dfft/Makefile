CC = gcc
OPENMP   = -fopenmp

TAREADORCC = tareador-clang
TAREADOR_FLAGS = -tareador-lite

CFLAGS  = -Wall -fno-inline -ffloat-store 
OPTG0   = -g -O0
OPT3    = -O3

CINCL   = -I. -I${FFTW3_HOME}/include
CLIBS   = -L. ${FFTW3_HOME}/lib/libfftw3f.a -lm

TARGETS  = 3dfft_seq 3dfft_v1 3dfft_v2 3dfft_v3 3dfft_v4 3dfft_omp
all: $(TARGETS) 

3dfft_seq:	3dfft_seq.c const_seq.h
	$(TAREADORCC) $(CFLAGS) $(OPTG0) $(CINCL) $< -o $@ $(CLIBS) $(TAREADOR_FLAGS)

3dfft_v1:	3dfft_v1.c const_seq.h
	$(TAREADORCC) $(CFLAGS) $(OPTG0) $(CINCL) $< -o $@ $(CLIBS) $(TAREADOR_FLAGS)

3dfft_v2:	3dfft_v2.c const_seq.h
	$(TAREADORCC) $(CFLAGS) $(OPTG0) $(CINCL) $< -o $@ $(CLIBS) $(TAREADOR_FLAGS)

3dfft_v3:	3dfft_v3.c const_seq.h
	$(TAREADORCC) $(CFLAGS) $(OPTG0) $(CINCL) $< -o $@ $(CLIBS) $(TAREADOR_FLAGS)

3dfft_v4:	3dfft_v4.c const_seq.h
	$(TAREADORCC) $(CFLAGS) $(OPTG0) $(CINCL) $< -o $@ $(CLIBS) $(TAREADOR_FLAGS)

3dfft_omp:	3dfft_omp.c const_omp.h
	$(CC) $(CFLAGS) $(OPT3) $(OPENMP) $(CINCL) $< -o $@ $(CLIBS) 

clean:
	rm -rf $(TARGETS)

ultraclean:
	rm -rf $(TARGETS) .tareador_precomputed_* logs *.log *.prv *.pcf *.raw dependency_graph*
