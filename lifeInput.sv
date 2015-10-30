module lifeInput #(parameter WIDTH=8, HEIGHT=8) (clk, reset, writeIn, setIn, dir, cursor, writeOut, setOut);
	input clk, reset, writeIn, setIn;
	input [3:0] dir;
	output reg [(WIDTH - 1):0][(HEIGHT - 1):0] cursor;
	output reg setOut, writeOut;
	wire [3:0] edgeDir;
	reg [$bits(WIDTH):0] xcoord;
	reg [$bits(HEIGHT):0] ycoord;
	
	genvar i;
	generate
		for(i = 0; i < 4; i++) begin : x
				edgeInput edger(clk, reset, dir[i], edgeDir[i]);
		end
	endgenerate
	
	always @(*) begin
		if(reset) begin
			writeOut = 0;
		end else begin
			writeOut = writeIn;
		end
		setOut = setIn;
	end
	
	localparam startX = WIDTH / 2;
	localparam startY = HEIGHT / 2;
	
	integer j;
	always @(posedge clk) begin
	assert(xcoord >= 0);
		if(reset) begin
			for (j=0; j<WIDTH; j=j+1) cursor[j] <= 0;
			xcoord <= startX;
			ycoord <= startY;
		end
		else if(writeIn) begin
			case(edgeDir)
				4'b1000: begin
					cursor[xcoord][ycoord] <= 0;
					cursor[(xcoord +WIDTH - 1) % WIDTH][ycoord] <= 1;
					xcoord <= (xcoord + WIDTH - 1) % WIDTH;
				end
				4'b0100: begin
					cursor[xcoord][ycoord] <= 0;
					cursor[xcoord][(ycoord + 1) % HEIGHT] <= 1;
					ycoord <= (ycoord + 1) % HEIGHT;
				end
				4'b0010: begin
					cursor[xcoord][ycoord] <= 0;
					cursor[xcoord][(ycoord + HEIGHT - 1) % HEIGHT] <= 1;
					ycoord <= (ycoord + HEIGHT - 1) % HEIGHT;
				end
				4'b0001: begin
					cursor[xcoord][ycoord] <= 0;
					cursor[(xcoord + 1) % WIDTH][ycoord] <= 1;
					xcoord <= (xcoord + 1) % WIDTH;
				end
				default: begin
					cursor[xcoord][ycoord] <= 1;
				end
			endcase
		end else begin
			for (j=0; j<$size(cursor); j=j+1) cursor[j] <= 0;
		end
	end
endmodule

module lifeInput_testbench();
	wire [19:0][19:0] cursor;
	wire setOut, writeOut;
	
	reg clk, reset, writeIn, setIn;
	reg [3:0] dir;
	
	
	// Set up the clock.
 parameter CLOCK_PERIOD=100;
 initial clk=1;
 always begin
 #(CLOCK_PERIOD/2);
 clk = ~clk;
 end
 
	lifeInput #(.WIDTH(20), .HEIGHT(20)) test(clk, reset, writeIn, setIn, dir, cursor, setOut, writeOut);
	
	
	initial begin
		reset = 1; writeIn = 1; setIn = 1; dir = 4'b0000;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		reset = 0;
		@(posedge clk);
		@(posedge clk);
		dir = 4'b1000;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		dir = 4'b0100;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		dir = 4'b0010;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		dir = 4'b0001;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		dir = 4'b1000;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		dir = 4'b1000;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		dir = 4'b1000;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		dir = 4'b1000;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		dir = 4'b1000;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		dir = 4'b1000;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		dir = 4'b1000;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		dir = 4'b1000;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		dir = 4'b1000;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		dir = 4'b1000;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		dir = 4'b1000;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		dir = 4'b1111;
		@(posedge clk); dir = 4'b0000;
		@(posedge clk);
		@(posedge clk);
		$stop;
	end
endmodule

