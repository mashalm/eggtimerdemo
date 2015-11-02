
module DecrementTime(clk, reset, wrtEn, decEn, minsSecsIn, 
	secOnes, secTens, minOnes, minTens);
	
	input clk, reset, wrtEn, decEn;
	input[15:0] minsSecsIn;
	
	output reg[3:0] secOnes, secTens, minOnes, minTens;
	
	always @ (posedge clk) begin
		if(reset == 1'b1) begin
			secOnes <= 4'b0000;
			secTens <= 4'b0000;
			minOnes <= 4'b0000;
			minTens <= 4'b0000;
		end
		else if(wrtEn == 1'b1) begin
		//read input otherwise ignore
			secOnes <= minsSecsIn[3:0];
			secTens <= minsSecsIn[7:4];
			minOnes <= minsSecsIn[11:8];
			minTens <= minsSecsIn[15:12];
		end
		else if(decEn == 1'b1) begin
			secOnes <= secOnes - 4'h1;
			if(secOnes == 4'h0) begin
				secOnes <= 4'h9;
				secTens <= secTens - 4'h1;
				if(secTens == 4'h0) begin
					secTens <= 4'h5;
					//nine is already set above
					minOnes <= minOnes - 4'b0001;
					if(minOnes == 4'h0) begin
						minOnes <= 4'h9;
						minTens <= minTens - 4'b0001;
						if(minTens == 4'h0) begin //everything is zero
							minOnes <= 4'h0;
							minTens <= 4'h0;
							secOnes <= 4'h0;
							secTens <= 4'h0;
							//this is kinda hacky?
						end
					end
				end //if
			end //if
		end //else if
	end //always

endmodule