#!/bin/tcsh

foreach r ( *.coor )
    dos2unix $r
    set name=`echo "$r" | sed s/"\.coor"//g`
    mkdir $name
    cp $r $name/
end

rm *.coor
