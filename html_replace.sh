#!/bin/bash

for dir in g*
do

  cd $dir

  sed s/gifs/"http\:\/\/cccbdb.nist.gov\/gifs"/g summary.html > test.html
  mv test.html summary.html

  cd ..

done
