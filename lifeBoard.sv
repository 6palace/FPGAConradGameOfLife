module lifeBoard #(parameter HEIGHT = 8, WIDTH=8)(clk, reset, board, cursor, write, set);
	input clk, reset, write, set;
	output [(WIDTH - 1):0][(HEIGHT - 1):0] board;
	input [(WIDTH - 1):0][(HEIGHT - 1):0] cursor;
	
	reg [23:0] clk_slower;
	reg prog;
	
	genvar i, j;
	generate
		for(i = 0; i < WIDTH; i++) begin : xaxis
			for(j = 0; j < HEIGHT; j++) begin : yaxis
					lifeCell subcell(clk, reset, {
						board[(i+WIDTH-1)% WIDTH][((j+HEIGHT-1) % HEIGHT)],board[(i)][(j+HEIGHT-1) % HEIGHT], 
						board[(i+1) % WIDTH][(j+HEIGHT-1) % HEIGHT], board[(i+1) % WIDTH][(j)], 
						board[(i+1) % WIDTH][(j+1) % HEIGHT], board[(i)][(j+1) % HEIGHT],
						board[(i+WIDTH-1)% WIDTH][(j+1) % HEIGHT], board[(i+WIDTH-1)% WIDTH][(j)]}, 
							board[i][j], prog, (cursor[i][j] & write), (set));
			end
		end
		
	endgenerate
	
	edgeInput clkSlowEdger(clk, reset, ~write & clk_slower[22], prog);
	always @(*) begin
	end
	
	always @(posedge clk) begin
		if(reset) begin
			clk_slower <= 24'b0;
		end else begin
			clk_slower <= clk_slower + 24'b1;
		end
		
	end
	
endmodule

module lifeBoard_testbench();
	wire[19:0][19:0] board;
	reg [19:0][19:0] cursor;
	reg clk, reset, write, set;
	
	// Set up the clock.
 parameter CLOCK_PERIOD=100;
 initial clk=1;
 always begin
 #(CLOCK_PERIOD/2);
 clk = ~clk;
 end
 
	lifeBoard #(.WIDTH(20), .HEIGHT(20)) test(clk, reset, board, cursor, write, set);
	integer j;
	initial begin
		reset = 1; 
		for (j=0; j<20; j=j+1) cursor[j] <= 0;
		write = 0;
		set = 0;
		@(posedge clk);
		@(posedge clk); 
		@(posedge clk); 
		reset = 0;
		@(posedge clk); 
		write = 1;
		cursor[0][0] = 1;
		@(posedge clk); 
		set = 1;
		@(posedge clk); 
		cursor[0][0] = 0;
		cursor[2][0] = 1;
		@(posedge clk); 
		cursor[2][0] = 0;
		cursor[3][0] = 1;
		@(posedge clk); 
		cursor[3][0] = 0;
		cursor[4][0] = 1;
		@(posedge clk); 
		@(posedge clk); 
		cursor[4][0] = 0;
		@(posedge clk); 
		@(posedge clk); 
		write = 0;
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk); 
		$stop;
		
	end
	
endmodule
