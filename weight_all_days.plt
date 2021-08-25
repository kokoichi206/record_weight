# Utils
positive(x) = (x > 0) ? x : 0
getValue(row,col,filename) = system('awk ''{if (NR == '.row.') print $'.col.'}'' '.filename.'')

day_sec=86400

stats "weight.txt"

day_now=(STATS_max_x-STATS_min_x)/day_sec
day_start=0

# graph settings
set xrange [day_start:day_now]
set title font "Arial,80"
set yrange [int(STATS_min_y):int(STATS_max_y)]
set xlabel "Time [days] from 12/25/20"
set ylabel "Weight [kg]"

# plot and linear fitting
plot 'weight.txt' u (($1-1608865150)/86400):($2) pointtype 7 pointsize 4 title "weight"
f(x)=a+b*x
g(x)=d+e*x+c*x**2
## fitting initial value
a=78
b=-0.1
c=0.1
# replot 78 - 0.1 * x title "ideal"
fit f(x) 'weight.txt' u (($1-1608865150)/86400):($2) via a,b

replot f(x) title "Linear fitting"

set terminal png
set output 'all_weight_from_1225.png'

# grid
set grid

replot

set terminal png
set output
