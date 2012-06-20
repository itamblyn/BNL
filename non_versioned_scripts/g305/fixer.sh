#!/bin/bash

for directory in g305????

do 

cd $directory

filename=`ls *.coor`

echo $filename

cp $filename "$filename".bkp

head -1 $filename > file.tmp
tail -n +2 $filename | sed s/"\,"/" "/g | awk '{print $1, $3, $4, $5, $6, $7, $8, $9}' >> file.tmp
grep -v "\@" file.tmp > file.tmp2

mv file.tmp2 $filename

rm file.tmp

cd ..

done

