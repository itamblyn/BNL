#!/usr/local/python/bin/python

import numpy

debug = False

inputFile = open('bnl.dat','r')

for line in inputFile.readlines():

    value_array = line.split()
    gamma = float(value_array[0])
    an_E_HOMO = numpy.max([float(value_array[1]),float(value_array[2])]) # homo of negatively charged acceptor
    do_E_HOMO = numpy.max([float(value_array[3]),float(value_array[4])]) # homo of neutral donor
    an_E_N = float(value_array[5])                                       # total energy of negatively charged acceptor 
    an_E_N1 = float(value_array[6])                                      # total energy of neutral acceptor
    do_E_N = an_E_N1   # this is because they are the same molecule
    do_E_N1 = float(value_array[7])                                      # total energy of positively charged donor
    dn = numpy.abs( do_E_HOMO + ( do_E_N1 - do_E_N )) 

    Iy = (dn)*27.2  # converts from Ha to eV

    print gamma, Iy
if (debug == True):
        print 'total energy of positively charged donor ', do_E_N1
        print 'total energy of neutral acceptor ', an_E_N1
        print 'homo of neutral donor ', do_E_HOMO

#an_E_HOMO # homo of negatively charged acceptor
#an_E_N    # total energy of negatively charged acceptor
#an_E_N1   # total energy of neutral acceptor


#do_E_HOMO # homo of neutral donor
#do_E_N    # total energy of neutral donor
#do_E_N1   # total energy of positively charged donor


