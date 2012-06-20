#!/bin/bash

for dir in g*
do
  cd $dir
  if [ -f exp2.asp.html ]
  then
    sed s/gifs/"http\:\/\/cccbdb.nist.gov\/gifs"/g exp2.asp.html > summary.html 
  fi
  cd ..
done

