#!/usr/bin/gnuplot -persist
# Set the output to a png file
#set terminal png size 500,500
# Set the output to the X screen
set terminal x11 
# The file we'll write to
#set output toto.png
# The graphic title
set title 'CV2 pressure'
#set xrange [0.125:0.250]
#set yrange [1:18]
set xrange [0:0.375]
set yrange [1:20]
#set datafile separator ";"
plot "../preprocess/python-scripts/data-exp.dat" using ($1-0.115):2 with lines
replot "../CV2-run-All/resu-cycle-0/postProcessing/probes/0/p" using 1:($2/100000) with lines
replot "../CV2-run-All/resu-cycle-0.03/postProcessing/probes/0.03/p" using 1:($2/100000) with lines
replot "../CV2-run-All/resu-cycle-0.125/postProcessing/probes/0.125/p" using 1:($2/100000) with lines
replot "../CV2-run-All/resu-cycle-0.155/postProcessing/probes/0.155/p" using 1:($2/100000) with lines
replot "../CV2-run-All/resu-cycle-0.250/postProcessing/probes/0.25/p" using 1:($2/100000) with lines
replot "../CV2-run-All/resu-cycle-0.280/postProcessing/probes/0.28/p" using 1:($2/100000) with lines
#replot "../CV2-run-All/postProcessing/probes/0/p" using 1:($2/100000) with lines
#replot "../CV2-run-All/postProcessing/probes/0/p" using 1:($3/100000) with lines
#replot "../CV2-run-All/postProcessing/probes/0/p" using 1:($4/100000) with lines
#replot "../CV2-run-All/postProcessing/probes/0/p" using 1:($5/100000) with lines
#replot "../CV2-run-All/postProcessing/probes/0/p" using 1:($6/100000) with lines
#replot "../CV2-run-All/postProcessing/probes/0/p" using 1:($7/100000) with lines
#replot "../CV2-run-All/postProcessing/probes/0/p" using 1:($8/100000) with lines
#replot "../CV2-run-All/postProcessing/probes/0/p" using 1:($9/100000) with lines

