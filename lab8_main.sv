module lab8_main #(parameter WIDTH=8, HEIGHT=8)(clk, reset, inDir, inSet, inWrite, outBoard, outCursor);
	input clk, reset, inSet, inWrite;
	input [3:0] inDir;
	output [(WIDTH-1):0][(HEIGHT-1):0] outBoard, outCursor;
//	output [7:0] outRed, outGreen, outSink;
	
	wire boardWrite, boardSet;
	
	lifeInput #(.WIDTH(WIDTH), .HEIGHT(HEIGHT)) in (clk, reset, inWrite, inSet, inDir, outCursor, boardWrite, boardSet);
	lifeBoard #(.WIDTH(WIDTH), .HEIGHT(HEIGHT)) board (clk, reset, outBoard, outCursor, boardWrite, boardSet);
	
	//ledArrayDriver driver(clk, outBoard, outCursor, outRed, outGreen, outSink);
	
endmodule

module lab8_main_testbench();
	reg clk, reset, inSet, inWrite;
	reg [3:0] inDir;
	wire [19:0][19:0] outBoard, outCursor;
	
	
	// Set up the clock.
 parameter CLOCK_PERIOD=100;
 initial clk=1;
 always begin
 #(CLOCK_PERIOD/2);
 clk = ~clk;
 end
	
	lab8_main #(.WIDTH(20), .HEIGHT(20)) test (clk, reset, inDir, inSet, inWrite, outBoard, outCursor);
 
	initial begin
		reset = 1; inDir = 4'b0000; inWrite = 1; inSet = 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		reset = 0;
		@(posedge clk);
		@(posedge clk);
		inSet = 1;
		inDir = 4'b1000;
		@(posedge clk);
		@(posedge clk);
		inDir = 4'b0000;
		@(posedge clk);
		inDir = 4'b1000;
		@(posedge clk);
		inDir = 4'b0000;
		@(posedge clk);
		inDir = 4'b0100;
		@(posedge clk);
		inDir = 4'b0000;
		@(posedge clk);
		@(posedge clk);
		inDir = 4'b0100;
		@(posedge clk);
		inSet = 0;
		inDir = 4'b0000;
		@(posedge clk);
		inDir = 4'b0001;
		@(posedge clk);
		inSet = 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		inWrite = 0;
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
		inWrite = 1; inDir = 4'b0000;
		@(posedge clk);
		inDir = 4'b0010;
		@(posedge clk);
		inDir = 4'b0000;
		@(posedge clk);
		@(posedge clk);
		inDir = 4'b0001;
		@(posedge clk);
		inDir = 4'b0000;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		$stop;
	
	end
endmodule
