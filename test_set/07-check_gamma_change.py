#!/usr/local/python/bin/python

import os, sys, commands, glob
import numpy as np

def linecheck(line):
    if len(line.split()) > 0:
        if line.split()[-1] == '--link1--': 
	    result = False
	else: 
	    result = True
    else:
        result = True

    return result

def main():
    try:
        prog = sys.argv[0]
#       a = float(sys.argv[1])
#       b = float(sys.argv[2])
    except IndexError:
#        print '\nusage: '+prog+' a b    (where a & b are numbers)\n'
        sys.exit(0)

    unoptFile = open('i.dat','r')
    gamma_data = []
    i_data = []
    for line in unoptFile:
        gamma_data.append(float(line.split()[0]))
        i_data.append(float(line.split()[1]))
    gamma_data, i_data = np.array(gamma_data), np.array(i_data)
    unopt_gamma =  gamma_data[np.argmin(i_data)]
    unoptFile.close()

    optFile = open('omega_opt_ideriv/i.dat','r')

    gamma_data = []
    i_data = []
    for line in optFile:
        gamma_data.append(float(line.split()[0]))
        i_data.append(float(line.split()[1]))
    gamma_data, i_data = np.array(gamma_data), np.array(i_data)
    opt_gamma = gamma_data[np.argmin(i_data)]
    optFile.close()

    print unopt_gamma - opt_gamma, ' '

#    get_coordinates = commands.getoutput('rm -f g2-97_b3lyp_neut.txt')
#    get_coordinates = commands.getoutput('wget http://www.cse.anl.gov/OldCHMwebsiteContent/compmat/g2-97_b3lyp_neut.txt')

#    os.system('sed s/LINK1/link1/g g2-97_b3lyp_neut.txt > g2-97_b3lyp_neut.clean')

#    line_count = int(commands.getoutput('wc -l g2-97_b3lyp_neut.clean').split()[0])


if __name__ == '__main__':
    main()
