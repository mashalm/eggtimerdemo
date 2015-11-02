
module TimeRegister(clk, reset, wrtEn, minEn, dIn, dOut);

	input clk, reset, wrtEn, minEn;
	input[7:0] dIn;
	
	output reg [15:0] dOut;
	
	always @ (posedge clk) begin
		if(reset == 1'b1)
			dOut <= 16'h0000;
		else begin
			if(wrtEn) begin
				if(minEn == 1'b1) dOut[15:8] <= dIn;
				else dOut[7:0] <= dIn;
			end
		end
	end

endmodule