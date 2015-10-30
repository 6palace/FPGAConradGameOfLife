module edgeInput (clk, reset, in, out);
	reg ps, ns;
	input in, clk, reset;
	output out;
	
	assign ns = in;
	assign out = in & ~ ps;
	
	
	always @(posedge clk)
		if(reset)
			ps <= 1;
		else
			ps <= ns;			
endmodule

module edgeInput_testbench();
	wire out;
	reg reset, in, clk;
	
	
 // Set up the clock.
 parameter CLOCK_PERIOD=100;
 initial clk=1;
 always begin
 #(CLOCK_PERIOD/2);
 clk = ~clk;
 end

	edgeInput tester(clk, reset, in, out);
	
	initial begin
		@(posedge clk);
		in = 0;
		@(posedge clk);
		in = 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		in = 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		in = 1;
		@(posedge clk);
		@(posedge clk);
		reset = 1;
		@(posedge clk);
		reset = 0;
		@(posedge clk);
		$stop;
		
	end
endmodule
