onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lab8_main_testbench/clk
add wave -noupdate /lab8_main_testbench/inWrite
add wave -noupdate /lab8_main_testbench/inSet
add wave -noupdate /lab8_main_testbench/inDir
add wave -noupdate -expand /lab8_main_testbench/outBoard
add wave -noupdate -expand /lab8_main_testbench/outCursor
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {799 ps} 0}
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
WaveRestoreZoom {0 ps} {3342 ps}
