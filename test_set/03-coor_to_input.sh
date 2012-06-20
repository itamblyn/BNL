#!/bin/tcsh

set RANDOM=`head -c 1 /dev/urandom | od | awk '{printf $2}'`

set cmd="$HOME/.python.tmp.py.$RANDOM"
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


foreach molecule_id ( bda_cis )

cd $molecule_id

echo $molecule_id

echo " " > input.template
echo '$molecule'            >> input.template
python $cmd *.coor negative >> input.template
tail -n +2 *.coor           >> input.template
echo '$end'                 >> input.template
cat ../input.template.0     >> input.template
echo " "                    >> input.template
echo '$molecule'            >> input.template
python $cmd *.coor neutral  >> input.template
tail -n +2 *.coor           >> input.template
echo '$end'                 >> input.template
cat ../input.template.1     >> input.template
echo " "                    >> input.template
echo '$molecule'            >> input.template
python $cmd *.coor positive >> input.template
tail -n +2 *.coor           >> input.template
echo '$end'                 >> input.template
cat ../input.template.2     >> input.template

foreach omega ( omega100 omega200 omega300 omega400 omega500 omega600 omega700 omega800 omega900 omega1000 omega2000 )

  rm -rf $omega
  mkdir $omega

  cd $omega

    set OMEGA=`echo $omega | sed s/omega//g`
    sed s/xOMEGA/"$OMEGA"/g ../input.template > input.in

  cd ..

end

cd ..

end

\rm $cmd
