#!/bin/tcsh

set TEMPLATES=$HOME/git/BNL/test_set/templates

foreach molecule_id ( g2g7* )

  cd $molecule_id

  echo $molecule_id

  rm -rf b3lyp_opt
  mkdir b3lyp_opt

  cd b3lyp_opt

    echo " " > input.in
    echo '$molecule'                      >> input.in
    cat ../g2*.coor                       >> input.in
    echo '$end'                           >> input.in 
    echo " "                              >> input.in 
    cat $TEMPLATES/input.template.B3LYP   >> input.in 

  cd ..

cd ..
end
