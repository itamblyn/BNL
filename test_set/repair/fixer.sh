#!/bin/tcsh

set parent=`pwd`

foreach directory (`cat ./broken.txt`)

cd $directory
    rm output.out g2g7* info.txt mol.pdb
    set xname=`echo "$directory" | sed s/"\/"/" "/g | awk '{print $2}'`
    qsub -N "$xname" ~/submit/qchem_SOF.s
    cd $parent
end


