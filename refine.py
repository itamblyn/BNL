#!/global/software/centos-5.x86_64/modules/Python/2.6.5/bin/python

import numpy

inputFile = open('i.dat','r')

gamma = []
J_y = []

for line in inputFile.readlines():

    gamma.append(float(line.split()[0])), J_y.append(float(line.split()[1]))


print gamma[J_y.index(min(J_y))]*100
