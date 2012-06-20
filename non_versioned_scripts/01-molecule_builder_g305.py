#!/usr/bin/python

#
# g297
# http://www.cse.anl.gov/OldCHMwebsiteContent/compmat/b3iongeom.htm
# http://chemistry.anl.gov/OldCHMwebsiteContent/compmat/g2-97_b3lyp_neut.txt
# http://www.cse.anl.gov/OldCHMwebsiteContent/compmat/g2-97_b3lyp_small.txt 
# http://www.cse.anl.gov/OldCHMwebsiteContent/compmat/g2-97_b3lyp_anion.txt
# http://www.cse.anl.gov/OldCHMwebsiteContent/compmat/g2-97_b3lyp_cation.txt
# http://www.cse.anl.gov/OldCHMwebsiteContent/compmat/g2-97_b3lyp_aux.txt
#
# g399
# http://www.cse.anl.gov/OldCHMwebsiteContent/compmat/g3-99.htm
# http://www.cse.anl.gov/OldCHMwebsiteContent/compmat/g3-3_b3lyp.txt
#
# g305 
# http://www.cse.anl.gov/OldCHMwebsiteContent/compmat/g3-05.htm
# http://www.cse.anl.gov/OldCHMwebsiteContent/compmat/g305_hb_b3.txt
# http://www.cse.anl.gov/OldCHMwebsiteContent/compmat/g305_nonhyd_b3.txt
# http://www.cse.anl.gov/OldCHMwebsiteContent/compmat/g305_third_b3.txt
#



import os, sys, commands, glob
import numpy

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
    # A clean way to ask for user input
    try:
        prog = sys.argv[0]
#       a = float(sys.argv[1])
#       b = float(sys.argv[2])
    except IndexError:
       # Tell the user what they need to give
        print '\nusage: '+prog+' a b    (where a & b are numbers)\n'
        # Exit the program cleanly
        sys.exit(0)
    print 'Current configuation is based on the g305 test set.'
    print 'Note that headers of other test sets are slightly different.'
    print 'Check the header file to see how many test sets are within a txt file!'
    print 'Program running. This should give valid .coor files for all but a few molecules'

    lines_in_route = 6 # for the g305, it is 6 

    molecule_prefix = 'g305'
    molecule_id = 1072

    os.system('rm -f *.coor')

    database = 'g305_third_b3.txt'
                 
                # g305_hb_b3.txt,     1000-1035
                # g305_nonhyd_b3.txt, 1036-1071
                # g305_third_b3.txt,  1072

    get_coordinates = commands.getoutput('rm -f ' + database)
    get_coordinates = commands.getoutput('wget http://www.cse.anl.gov/OldCHMwebsiteContent/compmat/' + database)

    os.system('sed s/LINK1/link1/g ' + database + ' > test_set.clean')

    line_count = int(commands.getoutput('wc -l test_set.clean').split()[0])
    inputFile = open('test_set.clean','r')

    line = inputFile.readline()
    i = 1

    while (i < line_count):

	filename = molecule_prefix+str(molecule_id)+'.coor'
	outputFile = open(filename,'w')
	for j in range(lines_in_route):
	    line = inputFile.readline() # this will be the gaussian route command
            i += 1
	line = inputFile.readline() # charge and multiplicity
	i += 1
        while (linecheck(line) == True) and (i < line_count):

            outputFile.write(line)
	    line = inputFile.readline()
            i += 1
        outputFile.close()
	molecule_id += 1

        line = inputFile.readline()
        i += 1

    os.system('rm -f test_set.clean')

if __name__ == '__main__':
    main()
