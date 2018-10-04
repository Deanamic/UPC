#!/bin/bash
# following option makes sure the job will run in the current directory
#$ -cwd
# following option makes sure the job has the same environmnent variables as the submission shell
#$ -V
# following option to change shell
#$ -S /bin/bash

PROG=pi_seq
make $PROG

size=1000000000

HOST=$(echo $HOSTNAME | cut -f 1 -d'.')

/usr/bin/time -o time-${PROG}-${HOST} ./$PROG $size
