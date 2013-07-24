#!/bin/bash


RANDOM=`head -c 1 /dev/urandom | od | awk '{printf $2}'`

cmd="$HOME/.python.tmp.py.$RANDOM"

cat > $cmd << END

import sys

inputFile = open(sys.argv[1],'r')
charge_mult = inputFile.readline()

charge = int(charge_mult.split(',')[0])
multiplicity = int(charge_mult.split(',')[1])

if ([charge,multiplicity] == [0,1]): 
    if (sys.argv[2] == 'negative'): print '-1,2'
    if (sys.argv[2] == 'neutral'):  print '0,1'
    if (sys.argv[2] == 'positive'):  print '1,2'

if ([charge,multiplicity] == [0,2]):
    if (sys.argv[2] == 'negative'): print '-1,1'
    if (sys.argv[2] == 'neutral'):  print '0,2'
    if (sys.argv[2] == 'positive'):  print '1,1'


if ([charge,multiplicity] == [0,3]):
    if (sys.argv[2] == 'negative'): print '-1,2'
    if (sys.argv[2] == 'neutral'):  print '0,3'
    if (sys.argv[2] == 'positive'):  print '1,2'

END

  rm -f output.xyz
  /usr/local/openbabel-2.3.1/bin/obabel -i qcout output.out -o xyz -O output.xyz
  head -1 ../*.coor > opt.coor # grab spin and mult from parent
  tail -n +3 output.xyz >> opt.coor # skip over xyz header

  echo " " > input.template
  echo '$molecule'              >> input.template
  python $cmd *.coor negative   >> input.template
  tail -n +2 *.coor             >> input.template
  echo '$end'                   >> input.template
  cat $HOME/git/BNL/test_set/templates/input.template.wPBE.0 >> input.template
  echo " "                      >> input.template
  echo '$molecule'              >> input.template
  python $cmd *.coor neutral    >> input.template
  tail -n +2 *.coor             >> input.template
  echo '$end'                   >> input.template
  cat $HOME/git/BNL/test_set/templates/input.template.wPBE.1 >> input.template
  echo " "                      >> input.template
  echo '$molecule'              >> input.template
  python $cmd *.coor positive   >> input.template
  tail -n +2 *.coor             >> input.template
  echo '$end'                   >> input.template
  cat $HOME/git/BNL/test_set/templates/input.template.wPBE.2 >> input.template

  for omega in omega100 omega200 omega300 omega400 omega500 omega600 omega700 omega800 omega900 omega1000 omega2000
  do
    rm -rf $omega
    mkdir $omega

    cd $omega

      OMEGA=`echo $omega | sed s/omega//g`
      sed s/xOMEGA/"$OMEGA"/g ../input.template > input.in
      /opt/n1ge/bin/lx24-amd64/qsub -N "$omega" ~/submit/qchem_SOF.s

    cd ..
  done

\rm $cmd
