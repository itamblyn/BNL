#!/bin/tcsh

foreach directory (`cat broken.txt`)

cd $directory

rm output.out g2g7* info.txt mol.pdb


qsub ../../qchem.sh

cd ../../

end

