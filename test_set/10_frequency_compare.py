#!/usr/bin/env python

import glob, os
import numpy as np

parent = os.getcwd()
os.system('rm -f freq_sofrsh.dat')
os.system('rm -f zpe_sofrsh.dat')

percent_difference_array = []

def digger():
    if os.path.exists('omega_opt_ideriv'):
        os.chdir('omega_opt_ideriv')
        digger() # recursive, keep digging
    else:
        return

def cleaner():
    inputFile=open('freq.dat','r')

    freq = []

    for line in inputFile.readlines():
        data = line.split()
        data.pop(0)
        freq +=data   # removes the first element, which is leftover from grep

    inputFile.close()

    outputFile = open('freq.dat','w')

    for frequency in freq:
        outputFile.write(frequency+' ')

    outputFile.close()

def main():

  dirlist = glob.glob('g2g7????')

  for dir in dirlist:
      os.chdir(dir)
      digger()  # this will dig down until it hits the bottom opt directory
      os.system('grep "Frequency:" output.out > freq.dat')
      cleaner() # removes the word Frequency
      zpeFile = open('zpe.dat','w')
      zpeFile.write(dir + ' ')
      zpeFile.close()
      os.system('grep "Zero" output.out | awk \'{print $5*349.75}\' >> zpe.dat')
      os.system('cat zpe.dat >> ' + parent + '/zpe_sofrsh.dat')
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

      if len(sofrsh) == len(b3lyp):
          mol_pd_bad = []
          for i in range(len(sofrsh)):
              percent_difference = np.around(((b3lyp[i]-sofrsh[i])/b3lyp[i])*100, 2)
              percent_difference_array.append(percent_difference)

              pd_tolerance = 10.0
              if abs(percent_difference) > pd_tolerance:
                  mol_pd_bad.append(percent_difference)

          if len(mol_pd_bad) > 0:
              fraction_bad = float(len(mol_pd_bad))/float(len(sofrsh))
              print 'id= ', dir, ' fraction[', np.around(fraction_bad, 2),'] of ',len(sofrsh),' worst=',np.around(max(mol_pd_bad),1),'%'
      
      os.chdir(parent)

  hist, bins = np.histogram(percent_difference_array, bins=np.arange(-50,50,1))
  print 'Average difference = ', np.average(percent_difference_array)
  print 'RMSE = ', (np.dot(percent_difference_array, percent_difference_array)/len(percent_difference_array))**.5
  histFile = open('hist.dat','w')

  for i in range(len(hist)):
      histFile.write(str(bins[i]) + ' ' + str(hist[i]) + '\n')  
  histFile.close() 
#  plt.hist(percent_difference_array, bins=np.arange(-20,20,1))
#  plt.show()
if __name__ == '__main__':
    main()
