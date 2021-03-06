onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lifeBoard_testbench/clk
add wave -noupdate /lifeBoard_testbench/write
add wave -noupdate /lifeBoard_testbench/set
add wave -noupdate -expand /lifeBoard_testbench/board
add wave -noupdate -expand /lifeBoard_testbench/cursor
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1200 ps} 0}
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
WaveRestoreZoom {965 ps} {4307 ps}
