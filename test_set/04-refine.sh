#!/bin/tcsh

set PYTHON=/usr/local/python
setenv PATH $PYTHON/bin:$PATH
setenv LD_LIBRARY_PATH $PYTHON/lib:$LD_LIBRARY_PATH

#$HOME/bnl/combined_bnl.sh

set RANDOM=`head -c 1 /dev/urandom | od | awk '{printf $2}'`
set cmd=$HOME/.python.tmp.py.$RANDOM

cat > $cmd << END

refine_number = 11

import numpy

inputFile = open('i.dat','r')

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


foreach directory (`echo "$list"`)

  rm -rf $directory
  mkdir $directory

  cd $directory
    set OMEGA=`echo "$directory" | sed s/omega//g`
    sed s/xOMEGA/"$OMEGA"/g ../input.template > input.in
    /opt/n1ge/bin/lx24-amd64/qsub -N "$xname" ~/submit/qchem.s
  cd ..

end


\rm $cmd
