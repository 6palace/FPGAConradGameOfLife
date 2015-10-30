onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /vgaTester_testbench/clk
add wave -noupdate /vgaTester_testbench/reset
add wave -noupdate /vgaTester_testbench/r
add wave -noupdate /vgaTester_testbench/g
add wave -noupdate /vgaTester_testbench/b
add wave -noupdate /vgaTester_testbench/hsync
add wave -noupdate /vgaTester_testbench/vsync
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1207 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 253
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {828 ps} {4170 ps}
