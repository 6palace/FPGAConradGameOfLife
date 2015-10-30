//This demands a input 25MHz clock
module lifeVGADriver #(parameter WIDTH=8, HEIGHT=8) (clk, reset, boardIn, cursorIn, redOut, greenOut, blueOut, Hsync, Vsync, blank, Gsync);
	input clk, reset;
	input [(WIDTH - 1):0][(HEIGHT - 1):0] boardIn, cursorIn;
	output [7:0] redOut, greenOut, blueOut;
	output Hsync, Vsync, blank, Gsync;
	
	wire [9:0] countH;
	wire [9:0] countV;
	wire inDisplay;
	
	vgaHVsyncGen syncer (clk, reset, Hsync, Vsync, countH, countV, inDisplay);
	
	localparam liveCell = 8'h00;
	localparam deadCell = 8'hFA;
	localparam cursorLiveg = 8'h2B;
	localparam cursorDeadg = 8'hFF;
	localparam cursorDeadoth = 8'hA8;
	localparam borderCol = 8'h33;
	
	localparam hDiv = 8;
	localparam vDiv = 16;
	
	localparam hOffset = 150;
	localparam vOffset = 35;
	
	localparam hMax = 630;
	localparam vMax = 475;
	
	wire [$bits(WIDTH):0] hpos;
	wire [$bits(HEIGHT):0] vpos;
	
	always @(*) begin
		
	end
	
	
	always @(posedge clk) begin
		if(reset) begin
			redOut <= liveCell;
			greenOut <= liveCell;
			blueOut <= liveCell;
		end else begin
			if(hpos < WIDTH && vpos < HEIGHT) begin
				case({boardIn[hpos][vpos], cursorIn[hpos][vpos]})
					2'b10: begin
						redOut <= liveCell;
						greenOut <= liveCell;
						blueOut <= liveCell;
					end
					2'b01: begin
						redOut <= cursorDeadoth;
						greenOut <= cursorDeadg;
						blueOut <= cursorDeadoth;
					end
					2'b11: begin
						redOut <= liveCell;
						greenOut <= cursorLiveg;
						blueOut <= liveCell;
					end
					default: begin
						redOut <= deadCell;
						greenOut <= deadCell;
						blueOut <= deadCell;
					end
				endcase
			end else begin
				redOut <= borderCol;
				greenOut <= borderCol;
				blueOut <= borderCol;
			end
			if(countH <= hOffset)
				hpos <= 0;
			else if(((countH - hOffset) % hDiv) == 0 && hpos < WIDTH) 
				hpos <= hpos + 1;
			if(countV <= vOffset)
				vpos <= 0;
			else if(((countV - vOffset) % hDiv) == 0 && vpos < HEIGHT && countH == hOffset - 5) 
				vpos <= vpos+ 1;
		end
		blank <= inDisplay;
		Gsync <= Hsync;
	end
	
	
	
endmodule