#!/bin/bash

parent=`pwd`

cat > cleaner.py << EOF
inputFile=open('freq.dat','r')

freq = []

for line in inputFile.readlines():
    data = line.split()
    data.pop(0)
    freq +=data

inputFile.close()

outputFile = open('freq.dat','w')

#freq.sort

for frequency in freq:
    outputFile.write(frequency+' ')

outputFile.close()
EOF



for dir in g2*
do
cd $dir
cd b3lyp_opt
pwd
grep "Frequency:" output.out > freq.dat
grep "Zero" output.out | awk '{print $5*349.75}' > zpe.dat
python $parent/cleaner.py
cd ..
cd ..
done

rm cleaner.py
