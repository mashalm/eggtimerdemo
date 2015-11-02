`timescale 1ns / 1ps

module TimerController_testbench;

	// inputs	
	reg clk, reset, set, startStop, isTimeFlat; // isTimeFlat is the flag when timer is done decrementing (when time is flat)
	// outputs
	wire decEn, flashEn, timeWrtEn, initValEn, minEn;
	
	// instantiation
	TimerController tc(clk, reset, set, startStop, isTimeFlat, 
	flashEn, decEn, timeWrtEn, initValEn, minEn);

	initial begin
		clk = 1'b0;
		reset = 1'b0;
		
		#10;
		$display("reset = %d, set = %d, startStop = %d, isTimeFlat = %d, flashEn = %d, decEn = %d, timeWrtEn = %d, initValEn = %d, minEn = %d",
		 reset, set, startStop, isTimeFlat, flashEn, decEn, timeWrtEn, initValEn, minEn);
		
		reset = 1'b1;
		set = 1'b0;
		startStop = 1'b0;
		isTimeFlat = 1'b0;
		#10; //should go to setSecs
		$display("reset = %d, set = %d, startStop = %d, isTimeFlat = %d, flashEn = %d, decEn = %d, timeWrtEn = %d, initValEn = %d, minEn = %d",
		 reset, set, startStop, isTimeFlat, flashEn, decEn, timeWrtEn, initValEn, minEn);
		
		reset = 1'b0;
		set = 1'b1;
		startStop = 1'b1;
		isTimeFlat = 1'b0;
		#10; //should go to setMins
		$display("reset = %d, set = %d, startStop = %d, isTimeFlat = %d, flashEn = %d, decEn = %d, timeWrtEn = %d, initValEn = %d, minEn = %d",
		 reset, set, startStop, isTimeFlat, flashEn, decEn, timeWrtEn, initValEn, minEn);
		
		
		reset = 1'b0;
		set = 1'b1;
		startStop = 1'b1;
		isTimeFlat = 1'b0;
		#10; //should be all zeroes, in waiting state
		$display("reset = %d, set = %d, startStop = %d, isTimeFlat = %d, flashEn = %d, decEn = %d, timeWrtEn = %d, initValEn = %d, minEn = %d",
		 reset, set, startStop, isTimeFlat, flashEn, decEn, timeWrtEn, initValEn, minEn);
		
		set = 1'b0;
		startStop = 1'b1;
		isTimeFlat = 1'b0;
		#10; //should go to runtimer
		$display("reset = %d, set = %d, startStop = %d, isTimeFlat = %d, flashEn = %d, decEn = %d, timeWrtEn = %d, initValEn = %d, minEn = %d",
		 reset, set, startStop, isTimeFlat, flashEn, decEn, timeWrtEn, initValEn, minEn);
		
		set = 1'b0;
		startStop = 1'b1;
		isTimeFlat = 1'b0;
		#10; //should go to stop time -- all zeroes
		$display("reset = %d, set = %d, startStop = %d, isTimeFlat = %d, flashEn = %d, decEn = %d, timeWrtEn = %d, initValEn = %d, minEn = %d",
		 reset, set, startStop, isTimeFlat, flashEn, decEn, timeWrtEn, initValEn, minEn);
		
		set = 1'b1;
		startStop = 1'b0;
		isTimeFlat = 1'b0;
		#10; //should do nothing
		$display("reset = %d, set = %d, startStop = %d, isTimeFlat = %d, flashEn = %d, decEn = %d, timeWrtEn = %d, initValEn = %d, minEn = %d",
		 reset, set, startStop, isTimeFlat, flashEn, decEn, timeWrtEn, initValEn, minEn);
		
		$finish;
	end
	
	always
		#5 clk = ~clk;
endmodule