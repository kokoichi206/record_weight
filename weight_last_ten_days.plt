
day_sec=86400

stats "weight.txt"

day_now=(STATS_max_x-STATS_min_x)/day_sec

# set x range recent 10 days
set xrange [day_now-10:day_now]
set title font "Arial,80"
set yrange [int(STATS_min_y):int(STATS_max_y)]
set xlabel "Time [days] from 12/25/20"
set ylabel "Weight [kg]"

plot 'weight.txt' u (($1-1608865150)/86400):($2) pointtype 7 pointsize 4 title "weight"
f(x)=a+b*x
g(x)=d+e*x+c*x**2
a=78
b=-0.1
c=0.1
fit f(x) 'weight.txt' u (($1-1608865150)/86400):($2) via a,b

replot f(x) title "fitting"

set terminal png
set output 'last_10_days_weight.png'

set grid
replot

set terminal x11
set output
