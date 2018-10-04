#!/bin/bash
# following option makes sure the job will run in the current directory
#$ -cwd
# following option makes sure the job has the same environmnent variables as the submission shell
#$ -V
# following option to change shell
#$ -S /bin/bash

PROG=pi_omp
make $PROG

size=1000000000

HOST=$(echo $HOSTNAME | cut -f 1 -d'.')

#export OMP_NUM_THREADS=1
export OMP_NUM_THREADS=8

/usr/bin/time -o time-${PROG}-${OMP_NUM_THREADS}-${HOST} ./$PROG $size
