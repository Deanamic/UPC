#!/bin/bash
# following option makes sure the job will run in the current directory
#$ -cwd
lscpu > ./cpu.txt
lstopo --of fig ./map.fig
