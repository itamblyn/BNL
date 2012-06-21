#!/bin/tcsh

# ALERT: for the neutral species, there are no beta spin values, so the E_HOMO is for the next charge state...

#
# alpha homo, beta homo, e
#

set PYTHON=/usr/local/python
setenv PATH $PYTHON/bin:$PATH
setenv LD_LIBRARY_PATH $PYTHON/lib:$LD_LIBRARY_PATH



foreach r ( omega??? omega???0 )
 cd $r
 echo $r | sed s/omega//g | awk '{printf $1/1000." "}' > bnl.dat
 grep -B 1 "\-\- Virtual" output.out | awk '{print $NF}' | grep "\." | head -2           | awk '{alpha=$1;getline;beta=$1;printf alpha" "beta" "}' >> bnl.dat 
 grep -B 1 "\-\- Virtual" output.out | awk '{print $NF}' | grep "\." | head -4 | tail -2 | awk '{alpha=$1;getline;beta=$1;printf alpha" "beta" "}' >> bnl.dat

 set e_negative=`grep "Convergence criterion met" output.out | head -1|           awk '{printf $2" "}'`
 set e_neutral=`grep  "Convergence criterion met" output.out | head -2| tail -1 | awk '{printf $2" "}'`
 set e_positive=`grep "Convergence criterion met" output.out | tail -1|           awk '{printf $2" "}'`

 echo $e_negative " " $e_neutral " " $e_positive >> bnl.dat

 cd ..

end

cat omega???/bnl.dat omega????/bnl.dat > bnl.dat

python $HOME/bnl/j_gamma.py > j.dat
python $HOME/bnl/i_gamma.py > i.dat
python $HOME/bnl/homo_check.py > homo.dat

set cmd="~/gnuplot.scr"
cat > $cmd << END
set xlabel 'gamma'
set ylabel 'Energy [eV]'
set xrange [0:*]
set yrange [0:*]
set data style linespoints
set nokey
set title "`pwd`"
set terminal png
set output 'j.png'
plot "j.dat"
quit
END

gnuplot $cmd

\rm $cmd

set cmd="~/gnuplot.scr"
cat > $cmd << END
set xlabel 'gamma'
set ylabel 'Energy [eV]'
set xrange [0:*]
set yrange [*:*]
set data style linespoints
set title "`pwd`"
set terminal png
set output 'Ediff.png'
plot "bnl.dat" u 1:(\$6 - \$7)*27.2 t 'E_negative - E_neutral', "bnl.dat" u 1:(\$8 - \$7)*27.2 t 'E_positive - E_neutral', 0 lt -1
quit
END

gnuplot $cmd

\rm $cmd

set cmd="~/gnuplot.scr"
cat > $cmd << END
set xlabel 'gamma'
set ylabel 'Energy [eV]'
set xrange [0:*]
set yrange [*:*]
set data style linespoints
set nokey
set title "`pwd`"
set terminal png
set output 'i.png'
plot "i.dat"
quit
END

gnuplot $cmd

\rm $cmd

set cmd="~/gnuplot.scr"
cat > $cmd << END
set xlabel 'gamma'
set ylabel 'Energy [eV]'
set xrange [0:*]
set yrange [*:*]
set data style linespoints
set title "`pwd`"
set terminal png
set output 'homo.png'
plot "homo.dat" u 1:2 t 'HOMO of negatively charged species', "homo.dat" u 1:3 t 'HOMO of neutral species', 0 lt -1
quit
END

gnuplot $cmd

\rm $cmd
