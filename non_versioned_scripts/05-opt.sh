#!/bin/tcsh

set cmd="$HOME/.python.tmp.py"
cat > $cmd << END

import numpy

inputFile = open('j.dat','r')

gamma = []
J_y = []

for line in inputFile.readlines():

    gamma.append(float(line.split()[0])), J_y.append(float(line.split()[1]))

best_omega = int(gamma[J_y.index(min(J_y))]*1000)


output_string = 'omega' + str(best_omega) 

print output_string


END

set OMEGA=`python $cmd | sed s/omega//g`

rm -rf omega_opt
mkdir omega_opt

grep -A 1000 "@@@" input.template | grep -B 1000 "@@@" | grep -v "@@@" | sed s/"JOBTYPE sp"/"JOBTYPE opt"/g | sed s/xOMEGA/"$OMEGA"/g > omega_opt/input.in

cd omega_opt

/usr/bin/qsub ../../template.opt

\rm $cmd
