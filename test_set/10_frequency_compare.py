#!/usr/bin/env python

import glob, os
import numpy as np
import matplotlib.pyplot as plt

parent = os.getcwd()
os.system('rm -f freq_sofrsh.dat')

percent_difference_array = []

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
      cleaner() # removes the work Frequency
      os.system('cat freq.dat >> ' + parent + '/freq_sofrsh.dat')

      sofrshFile = open('freq.dat','r')
      b3lypFile = open(parent + '/' + dir + '/b3lyp_opt/freq.dat', 'r')
  
      sofrsh = []

      for line in sofrshFile.readlines():
           for value in line.split():
               sofrsh.append(float(value))
      sofrshFile.close()

      b3lyp = []

      for line in b3lypFile.readlines():
           for value in line.split():
               b3lyp.append(float(value))
      b3lypFile.close()

#      print 'sofrsh' , sofrsh
#      print 'b3lyp' , b3lyp

      if len(sofrsh) == len(b3lyp):
          for i in range(len(sofrsh)):
              percent_difference = np.around( ((b3lyp[i]-sofrsh[i])/b3lyp[i])*100, 2)
              percent_difference_array.append(percent_difference)

#      print os.getcwd()
      os.chdir(parent)

  plt.hist(percent_difference_array, bins=np.arange(-20,20,1))
  plt.show()
if __name__ == '__main__':
    main()
