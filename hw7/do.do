add wave -position insertport sim:/clock/*
force -freeze sim:/clock/clk_1ms 1 0, 0 {1 ps} -r 2
force -freeze sim:/clock/clk_1sec 1 0, 0 {1000 ps} -r 2000
force reset_n 0
run 2000
force reset_n 1

#Make lists
add list \
sim:/clock/cnt \
sim:/clock/hrs_h \
sim:/clock/hrs_l \
sim:/clock/mins_h \
sim:/clock/mins_l

force mil_time 0
run 83158000
force mil_time 1
run 83158000

write list clock.list
