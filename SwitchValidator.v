
module SwitchValidator(clk, timeVal, validTime);

	input clk;
	input[15:0] timeVal;
	output reg [15:0] validTime;
	
	always @(posedge clk) begin
			//if the minstens > 5 set it to 5
			if(timeVal[15:12] > 4'h5)
				validTime[15:12] <= 4'b0101;
			//if the minsones > 9 set it to 9
			if(timeVal[11:8] > 4'h9)
				validTime[11:8] <= 4'h9;
			//if the secstens > 5 set it to 5
			if(timeVal[7:4] > 4'h5)
				validTime[7:4] <= 4'b0101;
			//if the minsones > 9 set it to 9
			if(timeVal[3:0] > 4'h9)
				validTime[3:0] <= 4'h9;
			else
				validTime[15:0] <= timeVal;
	end

endmodule