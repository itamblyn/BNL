#!/bin/bash

dir=`pwd | sed s/"\/"/" "/g | awk '{print $NF}'`

export PYTHON=/usr/local/python
export PATH=$PYTHON/bin:$PATH
export LD_LIBRARY_PATH=$PYTHON/lib:$LD_LIBRARY_PATH

export RANDOM=`head -c 1 /dev/urandom | od | awk '{printf $2}'`
export cmd=$HOME/.python.tmp.py.$RANDOM

cat > $cmd << END

import numpy

inputFile = open('i.dat','r')

gamma = []
J_y = []

for line in inputFile.readlines():

    gamma.append(float(line.split()[0])), J_y.append(float(line.split()[1]))

best_omega = int(gamma[J_y.index(min(J_y))]*1000)


output_string = 'omega' + str(best_omega) 

print output_string


END

OMEGA=`python $cmd | sed s/omega//g`

rm -rf omega_opt
mkdir omega_opt

cd omega_opt

grep -A 1000 "@@@" ../input.template | grep -B 1000 "@@@" | grep -v "@@@" | sed s/xOMEGA/"$OMEGA \nJOBTYPE                 opt"/g > opt.in

echo " "           >  freq.in
echo "@@@"         >> freq.in
echo " "           >> freq.in
echo "\$molecule " >> freq.in
echo "READ "       >> freq.in
echo "\$end "      >> freq.in
echo " "           >> freq.in

grep -A 1000 "xc_functional" opt.in | sed s/"JOBTYPE                 opt"/"JOBTYPE                 freq\nIDERIV 0\nSCF_GUESS READ"/g >> freq.in

cat opt.in freq.in > input.in
rm opt.in freq.in


/opt/n1ge/bin/lx24-amd64/qsub -N "$dir" ~/submit/qchem.s

cd ..

\rm $cmd
