module lifeCell(clk, reset, inputs, o, prog, write,set);
	input clk, reset, prog, write, set;
	input [7:0] inputs;
	output reg o;
	
	
	wire [2:0] sum;
	reg ps, ns;
	
	assign sum = inputs[0] + inputs[1] + inputs[2] + inputs[3] + inputs[4] + inputs[5] + inputs[6] + inputs[7];
	
	always @(*)
		if(write)
			ns = set;
		else 
			case(sum)
				3'b011: ns = 1;
				3'b010: ns = ps;
				default: ns = 0;
			endcase
	
	always @(posedge clk) begin
		if(reset) begin
			o <= 0;
			ps <= 0;
		end 
		else if(prog | write) begin
			o <= ns;
			ps <= ns;
		end
	end
				
endmodule

module lifeCell_testbench();
	wire out;
	reg [7:0] in;
	reg clk, reset, write, set, prog;
	
	
 // Set up the clock.
 parameter CLOCK_PERIOD=100;
 initial clk=1;
 always begin
 #(CLOCK_PERIOD/2);
 clk = ~clk;
 end
	
	lifeCell test(clk, reset, in, out, prog, write, set);
	
	initial begin
		reset = 1; in = 8'b0; prog = 1; set = 0; write = 0;
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		reset = 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		in = 8'b00101000;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		in = 8'b11100000;
		@(posedge clk);
		@(posedge clk);
		prog = 0;
		@(posedge clk);
		in = 8'b11110000;
		@(posedge clk);
		@(posedge clk);
		write = 1;
		@(posedge clk);
		set = 1;
		in = 8'b00101010;
		@(posedge clk);
		@(posedge clk);
		set = 0;
		@(posedge clk);
		in = 8'b00100000;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		
		$stop;
	end
endmodule
