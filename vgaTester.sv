module vgaTester(clk, reset, hsync, vsync, r, g, b, blank, sync);
	input clk, reset;
	
	output hsync, vsync;
	output reg [7:0] r, g, b;
	output reg blank, sync;
	
	wire [9:0] countH;
	wire [9:0] countV;
	wire inDisplay;
	
	vgaHVsyncGen syncer (clk, reset, hsync, vsync, countH, countV, inDisplay);
	
	parameter OFF = ~8'h00;
	
	// Draw a border around the screen
wire border = (countH[9:3]==0) || (countH[9:3]==79) || (countV[9:3]==0) || (countV[9:3]==59);
wire [7:0] R = 8'hFF;
wire [7:0] G = 8'hFF;
wire [7:0] B = 8'hFF;

always @(posedge clk) begin
	if(border) begin
		r <= R;
		g <= G;
		b <= B;
	end else begin
		r <= 8'h00;
		g <= 8'h00;
		b <= 8'h00;
	end
	blank <= inDisplay;
	sync <= hsync;
end
endmodule

module vgaTester_testbench();
	wire [7:0] r, g, b;
	wire hsync, vsync, blank, sync;
	reg clk, reset;
	
	parameter CLOCK_PERIOD=2;
	 initial clk=1;
	 always begin
	 #(CLOCK_PERIOD/2);
	 clk = ~clk;
	 end
	
	vgaTester test (clk, reset, hsync, vsync, r, g, b, blank, sync);
	
	integer i;
	initial begin
		reset = 1;
		@(posedge clk);
		reset = 0;
		for(i = 0; i < 2000000; i++)
			@(posedge clk);
			
		$stop;
	end
endmodule