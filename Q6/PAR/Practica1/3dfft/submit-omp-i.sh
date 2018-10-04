#!/bin/bash
# following option makes sure the job will run in the current directory
#$ -cwd
# following option makes sure the job has the same environmnent variables as the submission shell
#$ -V
# following option to change shell
#$ -S /bin/bash

PROG=3dfft_omp
make $PROG

export OMP_NUM_THREADS=4
export OMP_SCHEDULE="static"

HOST=$(echo $HOSTNAME | cut -f 1 -d'.')

export LD_PRELOAD=${EXTRAE_HOME}/lib/libomptrace.so
./$PROG 
unset LD_PRELOAD

mpi2prv -f TRACE.mpits -o ${PROG}-${OMP_NUM_THREADS}-${HOST}.prv -e $PROG -paraver
rm -rf  TRACE.mpits set-0 >& /dev/null
