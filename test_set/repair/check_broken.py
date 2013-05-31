#!/usr/local/python/bin/python

import sys, os, commands

issue_command = commands.getoutput('find .\/ -name output* | xargs grep p4_error | sed s/"output"/" "/g | awk \'{print $1}\'  > broken.tmp')
issue_command = commands.getoutput('echo "Conv fail" >> broken.tmp')
issue_command = commands.getoutput('find ./ -name output* | xargs grep "Convergence failure" | sed s/"output"/" "/g | awk \'{print $1}\'  >> broken.tmp')


inputFile = open('broken.tmp','r')

previous_line = ' '

outputFile = open('broken.txt','w')

for line in inputFile.readlines():

    directory = line
    if (directory != previous_line): 
        outputFile.write(directory)
    previous_line = directory

outputFile.close()

inputFile.close()


issue_command = commands.getoutput('rm -f broken.tmp')
