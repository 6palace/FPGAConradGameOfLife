module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_CLK);
 output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 output [9:0] LEDR;
 input [3:0] KEY;
 input [9:0] SW;
 input CLOCK_50; // 50MHz clock
 output [7:0] VGA_R, VGA_G, VGA_B;
 output VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_CLK;

 //clock creation
 wire [31:0] clk;
 parameter whichClock = 0; // clock timing selector
 clock_divider cdiv (CLOCK_50, clk);
 
 
			// Default values, turns off the HEX displays
			assign HEX0 = 7'b1111111;
			assign HEX1 = 7'b1111111;
			assign HEX2 = 7'b1111111;
			assign HEX3 = 7'b1111111;
			assign HEX4 = 7'b1111111;
			assign HEX5 = 7'b0; 
			
		localparam width = 64;
		localparam height = 32;
			
		wire [(width - 1):0][(height - 1):0] wireBoard, wireCursor;
			
		lab8_main #(.WIDTH(width), .HEIGHT(height)) main (clk[0], SW[9], KEY[3:0], SW[1], SW[0], wireBoard, wireCursor);
		lifeVGADriver #(.WIDTH(width), .HEIGHT(height)) display (clk[0], SW[9], wireBoard, wireCursor, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N);
		assign VGA_CLK = clk[whichClock];
	
	
endmodule 

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, 
// [25] = 0.75Hz, ...
module clock_divider (clock, divided_clocks);
 input clock;
 output [31:0] divided_clocks;
 reg [31:0] divided_clocks;

 initial
 divided_clocks = 32'b0;

 always @(posedge clock)
 divided_clocks = divided_clocks + 1;
endmodule 