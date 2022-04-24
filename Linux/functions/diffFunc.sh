#!/bin/bash
#finding the difference between to text files
#input 1 is file 1, input 2 is file 2, input 3 alternative file 1, input 4 is the alternative file 2, input 5 is the output file.

sort $1 > $3
sort $2 > $4

cat $3 > $1
cat $4 > $2

comm -2 -3 --nocheck-order $1 $2 > $5