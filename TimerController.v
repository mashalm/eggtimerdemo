
module TimerController(clk, reset, set, startStop, isTimeFlat, 
	flashEn, decEn, timeWrtEn, initValEn, minEn);
	
	parameter Reset = 3'b000, SetSec = 3'b001, SetMin = 3'b010, WaitForStart = 3'b011, 
		RunTimer = 3'b100, Flash = 3'b101;

	input clk, reset, set, startStop, isTimeFlat;
	output reg flashEn, decEn, timeWrtEn, initValEn, minEn;
	
	reg[2:0] state;
	
	always @ (posedge clk) begin
		if(reset) state <= reset;
		else begin
			case(state)
				Reset: begin
					if(set) state <= SetSec;
				end
				SetSec: begin
					if(set) state <= SetMin;
				end
				SetMin: begin
					if(set) state <= WaitForStart;
				end
				WaitForStart: begin
					if(startStop) state <= RunTimer;
				end
				RunTimer: begin
					if(startStop) state <= WaitForStart;
					else if(isTimeFlat) state <= Flash;
				end
				Flash: begin
					if(reset) state <= SetSec;
				end
				default: begin
					state <= Reset;
				end
			endcase
		end
	end
	
	always @ (state) begin
		case(state)
			Reset: begin
				flashEn <= 1'b0;
				decEn <= 1'b0;
				timeWrtEn <= 1'b0;
				initValEn <= 1'b0;
				minEn <= 1'b0;
			end
			SetSec: begin
				flashEn <= 1'b0;
				decEn <= 1'b0;
				timeWrtEn <= 1'b1;
				initValEn <= 1'b1;
				minEn <= 1'b0;
			end
			SetMin: begin
				flashEn <= 1'b0;
				decEn <= 1'b0;
				timeWrtEn <= 1'b1;
				initValEn <= 1'b1;
				minEn <= 1'b1;
			end
			WaitForStart: begin
				flashEn <= 1'b0;
				decEn <= 1'b0;
				timeWrtEn <= 1'b0;
				initValEn <= 1'b0;
				minEn <= 1'b0;
			end
			RunTimer	: begin
				flashEn <= 1'b0;
				decEn <= 1'b1;
				timeWrtEn <= 1'b0;
				initValEn <= 1'b0;
				minEn <= 1'b0;
			end
			Flash: begin
				flashEn <= 1'b1;
				decEn <= 1'b0;
				timeWrtEn <= 1'b0;
				initValEn <= 1'b0;
				minEn <= 1'b0;
			end
			default: begin
				flashEn <= 1'b0;
				decEn <= 1'b0;
				timeWrtEn <= 1'b0;
				initValEn <= 1'b0;
				minEn <= 1'b0;
			end
		endcase
	end

endmodule