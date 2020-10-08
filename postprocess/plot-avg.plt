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
replot "../CV2-run-All/resu-cycle-0/postProcessing/volumeAverage/0/volRegion.dat" using 1:($2/100000) with lines
replot "../CV2-run-All/resu-cycle-0.03/postProcessing/volumeAverage/0.03/volRegion.dat" using 1:($2/100000) with lines
replot "../CV2-run-All/resu-cycle-0.125/postProcessing/volumeAverage/0.125/volRegion.dat" using 1:($2/100000) with lines
replot "../CV2-run-All/resu-cycle-0.155/postProcessing/volumeAverage/0.155/volRegion.dat" using 1:($2/100000) with lines
replot "../CV2-run-All/resu-cycle-0.250/postProcessing/volumeAverage/0.25/volRegion.dat" using 1:($2/100000) with lines
replot "../CV2-run-All/resu-cycle-0.280/postProcessing/volumeAverage/0.28/volRegion.dat" using 1:($2/100000) with lines
#replot "../CV2-run-All/resu-cycle-0.250/postProcessing/volumeAverage/0.25/volRegion.dat" using 1:($2/100000) with lines
#replot "../CV2-run-All/resu-cycle-0.280/postProcessing/volumeAverage/0.28/volRegion.dat" using 1:($2/100000) with lines
#replot "../CV2-run-All4/resu-cycle-0.280/postProcessing/volumeAverage/0.28/volRegion.dat" using 1:($2/100000) with lines
#replot "../CV2-run-All2/postProcessing/volumeAverage/0.28/volRegion.dat" using 1:($2/100000) with lines
#replot "../CV2-run-All/postProcessing/volumeAverage/0.28/volRegion.dat" using 1:($2/100000) with lines
#replot "../CV2-run-All/postProcessing/volumeAverage/0.155/volRegion.dat" using 1:($2/100000) with lines
#replot "../CV2-run-All4/postProcessing/volumeAverage/0.162/volRegion.dat" using 1:($2/100000) with lines
#replot "../CV2-run-All5/postProcessing/volumeAverage/0.162/volRegion.dat" using 1:($2/100000) with lines
#replot "../CV2-run-All/postProcessing/volumeAverage/0.03/volRegion.dat" using 1:($2/100000) with lines

