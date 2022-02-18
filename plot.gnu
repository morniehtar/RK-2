#! /usr/bin/gnuplot

set encoding iso_8859_1
set tmargin 1
set tics out
#set nokey
set grid

set style line 1 lt rgb "#409ff1" lw 2 pt 3 ps 0.5 #Blue, thick
set style line 2 lt rgb "#cd1200" lw 1.5 pt 3 ps 0.5 dt 2 #Red, thin, dotted

plot "./output.dat" using 1:3 smooth csplines linestyle 2 title "Exact solution", \
"./output.dat" using 1:2 smooth csplines linestyle 1 title "Runge-Kutta"

pause mouse close
