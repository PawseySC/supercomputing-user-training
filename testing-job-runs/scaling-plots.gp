set encoding iso_8859_1
set term pngcairo size 1280,960 color font "Arial,24" enha lw 2

set key bottom right
set xlabel "Process count"
set xrange [0:3200]
set xtics 0,500
set mxtics 5

set out "md_lammps_water_800k_runtime.png"
set title "Relative Runtime"
set yrange [0:1.05]
set ytics 0,0.1
set mytics 5
p 'scaling-data' u 1:3 w lp not

set out "md_lammps_water_800k_speedup.png"
set title "Strong Scaling Speedup"
set yrange [0:50]
set ytics 0,5
set mytics 5
p 'scaling-data' u 1:4 w lp not, \
  x/24 dt 5 lc 0 t "Ideal Speedup"

set out "md_lammps_water_800k_efficiency.png"
set title "Strong Scaling Efficiency"
set yrange [0:105]
set ytics 0,10
set mytics 5
p 'scaling-data' u 1:5 w lp not

set out "md_lammps_water_800k_cost.png"
set title "Relative Total Cost"
set yrange [0.9:3]
set ytics 0,0.2
set mytics 2
p 'scaling-data' u 1:6 w lp not


