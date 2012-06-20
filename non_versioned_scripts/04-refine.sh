#!/bin/tcsh

$HOME/bnl/combined_bnl.sh

set cmd="$HOME/.python.tmp.py"
cat > $cmd << END

refine_number = 11

import numpy

inputFile = open('j.dat','r')

gamma = []
J_y = []

for line in inputFile.readlines():

    gamma.append(float(line.split()[0])), J_y.append(float(line.split()[1]))

best_omega = int(gamma[J_y.index(min(J_y))]*1000)


output_string = ' '

for i in range(refine_number):

    if (i != int(refine_number/2)): output_string += 'omega' + str(best_omega - 50 + i*10) + ' '

print output_string


END

set list=`python $cmd`
set xname=`pwd | sed s/"\/"/" "/g | awk '{print $NF}'`

sed s/xList/"$list"/g ../refine.qchem.template | sed s/xName/"$xname"/g > refine.qchem

foreach directory (`echo "$list"`)

  rm -rf $directory
  mkdir $directory

  cd $directory
    set OMEGA=`echo "$directory" | sed s/omega//g`
    sed s/xOMEGA/"$OMEGA"/g ../input.template > input.in
  cd ..

end

/usr/bin/qsub refine.qchem

\rm $cmd
