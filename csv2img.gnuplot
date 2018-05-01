#!/usr/bin/gnuplot -persist
if (!exists("fileoutput")) fileoutput='123.dat'

set terminal png size 319,300 enhanced font "Helvetica,10"
set output fileOut
set datafile separator ","
set tics out
set yrange [-3:3]
plot fileIn using 2 with line notitle
