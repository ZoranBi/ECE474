add wave -r -hex /*
force a_in 10#14
force b_in 10#9
force -freeze sim:/mult/clk 1 0, 0 {50 ns} -r 100

#Make lists
add list -nodelta
#configure list -strobestart {99 ns} -strobeperiod {100 ns}
#configure list -usestrobe 1
add list -notrigger -hex -width 12 -label a_in a_in
add list -notrigger -hex -width 12 -label start start
add list -notrigger -hex -width 12 -label done done
add list -notrigger -hex -width 12 -label product product

force reset 1
force start 0
run 200
run 50
force reset 0
run 100
run 50
force start 1
run 100
force start 0
run 500
run 7000

#output list file
write list mult.list
