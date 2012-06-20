#!/bin/bash

grep -B 2 "\-\- Virtual" output.out | awk '{print $NF}' | grep "\." | awk '{alpha=$1;getline;beta=$1;print alpha}'
