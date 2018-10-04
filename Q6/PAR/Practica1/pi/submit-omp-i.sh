#!/bin/bash
# following option makes sure the job will run in the current directory
#$ -cwd
# following option makes sure the job has the same environmnent variables as the submission shell
#$ -V
# following option to change shell
#$ -S /bin/bash

PROG=pi_omp
make $PROG

size=100000000

#export OMP_NUM_THREADS=1
export OMP_NUM_THREADS=8

HOST=$(echo $HOSTNAME | cut -f 1 -d'.')

export LD_PRELOAD=${EXTRAE_HOME}/lib/libomptrace.so
./$PROG $size
unset LD_PRELOAD

mpi2prv -f TRACE.mpits -o ${PROG}-${size}-${OMP_NUM_THREADS}-${HOST}.prv -e $PROG -paraver
rm -rf  TRACE.mpits set-0 >& /dev/null
