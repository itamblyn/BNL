#!/bin/tcsh

foreach r ( *.coor )

    set name=`echo "$r" | sed s/"\.coor"//g`
    mkdir $name
    cp $r $name/
end
