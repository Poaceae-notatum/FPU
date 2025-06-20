onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/reset
add wave -noupdate /tb/dut/clock
add wave -noupdate /tb/dut/num_1
add wave -noupdate /tb/dut/num_2
add wave -noupdate /tb/dut/reset
add wave -noupdate /tb/dut/data_out
add wave -noupdate /tb/dut/status_out
add wave -noupdate /tb/dut/den_a
add wave -noupdate /tb/dut/exp_a
add wave -noupdate /tb/dut/man_a
add wave -noupdate /tb/dut/den_b
add wave -noupdate /tb/dut/exp_b
add wave -noupdate /tb/dut/man_b
add wave -noupdate /tb/dut/status
add wave -noupdate /tb/dut/main/man_temp
add wave -noupdate /tb/dut/main/den_temp
add wave -noupdate /tb/dut/main/exp_temp
add wave -noupdate /tb/dut/main/outpstatus
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12749 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 212
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {487334520 ps} {488035026 ps}
