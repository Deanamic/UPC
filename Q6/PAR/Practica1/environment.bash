#!/bin/bash
export SOFT_ROOT=/Soft/PAR

# FFTW3 library
export FFTW3_HOME=$SOFT_ROOT/fftw3
export LD_LIBRARY_PATH=$FFTW3_HOME/lib

# Extrae and Paraver
#export EXTRAE_HOME=$SOFT_ROOT/extrae/3.4.1
export EXTRAE_HOME=$SOFT_ROOT/extrae/3.5
export PATH=$EXTRAE_HOME/bin/:$PATH
export LD_LIBRARY_PATH=/Soft/libunwind/current/lib/:$EXTRAE_HOME/lib:$LD_LIBRARY_PATH
export EXTRAE_LABELS=./user-events.dat
export EXTRAE_ON=TRUE 
export EXTRAE_CONFIG_FILE=./extrae.xml

export PARAVER_HOME=$SOFT_ROOT/paraver/4.5.1
export PATH=$PARAVER_HOME/bin:$PATH

# Dimemas for Tareador simulations
export TAREADOR_HOME=$SOFT_ROOT/TAREADOR
export PATH=$TAREADOR_HOME/install/trf2trf/bin:$PATH
export PATH=$TAREADOR_HOME/src/scripts/dimemas_simulations:$PATH
export PATH=$TAREADOR_HOME/install/dimemas-5.2.3-linux-x86_64/bin:$PATH

# Tareador GuiED
export TAREADOR_HOME=$SOFT_ROOT/TAREADOR
export TAREADOR_GUI_ROOT=$TAREADOR_HOME/src/TAREADOR_GUI_LLVM
export TAREADOR_ICONS=$TAREADOR_GUI_ROOT/xdot/icons
export PATH=$TAREADOR_GUI_ROOT/backend:$TAREADOR_GUI_ROOT/xdot:$PATH
export PYTHONPATH=$TAREADOR_GUI_ROOT:$PYTHONPATH

# Tareador LLVM
export TAREADOR_LLVM_HOME=$TAREADOR_HOME/install/llvm-clang
export TAREADOR_INSTALL_DIRECTORY=$TAREADOR_LLVM_HOME
export PATH=$TAREADOR_LLVM_HOME/bin:$PATH

# New version of gcc supporting OpenMP 4.5
export PATH=/Soft/gcc/6.2.0/bin:$PATH
export LD_LIBRARY_PATH=/Soft/gcc/6.2.0/lib64:$LD_LIBRARY_PATH

# To get rid of problems ...
export LC_ALL="en_US.utf-8"
alias evince="LD_LIBRARY_PATH= /usr/bin/evince"
