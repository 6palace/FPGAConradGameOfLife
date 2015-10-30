module vgaHVsyncGen(clk, reset, Hsync, Vsync, counterX, counterY, displayZone);
	input clk, reset;
	output reg Hsync, Vsync;
	output reg[9:0] counterX;
	output reg[9:0] counterY;
	output reg displayZone;
	wire counterXMax;
	wire displayX;
	wire displayY;
	
	assign counterXMax = (counterX == 800);
	assign displayX = (counterX > 150 && counterX < 780);
	assign displayY = (counterY > 35 && counterY < 510);
	
	always @(posedge clk) begin
		if(reset) begin
			counterX <= 0;
			counterY <= 0;
		end else begin
			if(counterXMax) begin
				counterX <= 0;
				if(counterY == 521)
					counterY <= 0;
				else
					counterY <= counterY + 9'b1;
			end else
				counterX <= counterX + 10'b1;
			Hsync <= ~(counterX < 45);
			Vsync <= ~(counterY == 0);
			displayZone <= displayX && displayY;
		end
			
	end
endmodule
