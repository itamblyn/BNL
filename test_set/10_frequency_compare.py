#!/usr/bin/env python

import glob, os

parent = os.getcwd()
os.system('rm -f sofrsh.dat')

def digger():
    if os.path.exists('omega_opt_ideriv'):
        os.chdir('omega_opt_ideriv')
        digger()
    else:
        return

def cleaner():
    inputFile=open('freq.dat','r')

    freq = []

    for line in inputFile.readlines():
        data = line.split()
        data.pop(0)
        freq +=data

    inputFile.close()

    outputFile = open('freq.dat','w')

    freq.sort

    for frequency in freq:
        outputFile.write(frequency+' ')

    outputFile.close()

def main():

  dirlist = glob.glob('g2g7????')

  for dir in dirlist:
      os.chdir(dir)
      digger()  # this will dig down until it hits the bottom opt directory
      os.system('grep "Frequency:" output.out > freq.dat')
      cleaner()
      os.system('cat freq.dat >> ' + parent + '/freq_sofrsh.dat')
      print os.getcwd()
      os.chdir(parent)

if __name__ == '__main__':
    main()
