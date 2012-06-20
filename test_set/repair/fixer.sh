#!/bin/tcsh

foreach directory (`cat ~/bnl/test_set/repair/broken.txt`)

cd $directory

    rm output.out g2g7* info.txt mol.pdb
    set xname=`echo "$directory" | sed s/"\/"/" "/g | awk '{print $1}'`
    qsub -N "$xname" ../../qchem.sh

cd ../../

end


