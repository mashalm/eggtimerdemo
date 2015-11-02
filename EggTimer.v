module EggTimer(CLOCK_50, KEY, SW, HEX3, HEX2, HEX1, HEX0, LEDR);

	input CLOCK_50;
	input [2:0] KEY;
	input[7:0] SW;
	
	output[6:0] HEX3;
	output[6:0] HEX2;
	output[6:0] HEX1;
	output[6:0] HEX0;
	output[9:0] LEDR;
	
	//assign inputs correctly
	wire reset = ~KEY[0];
	wire set = ~KEY[1];
	wire startStop = ~KEY[2];
	wire clk = CLOCK_50;
	
	//clock divider for decrementer:
	wire oneSecClock;
	ClockDivider #(33000000) dcd(clk, oneSecClock);
	
	//clock divider for flasher:
	wire halfSecClock;
	ClockDivider #(25000000) fcd(clk, halfSecClock);
	
	//declare required wires
	wire [3:0] secOnes, secTens, minOnes, minTens;
	wire isTimeFlat = (secOnes + secTens + minOnes + minTens == 0) ? 1 : 0;
	//controller outputs:
	wire flashEn, decEn, timeWrtEn, initDecEn, minEn;	
	TimerController tc(clk, reset, set, startStop, isTimeFlat, 
		flashEn, decEn, timeWrtEn, initDecEn, minEn);
	
	wire[15:0] initMinsSecs;
	TimeRegister tr(clk, reset, timeWrtEn, minEn, SW, initMinsSecs);

	DecrementTime dt(oneSecClock, reset, initDecEn, decEn, initMinsSecs, 
		secOnes, secTens, minOnes, minTens);
	
	FlashLights fl(clk, flashEn & halfSecClock, LEDR);

	dec2_7seg d1(secOnes, HEX0);
	dec2_7seg d2(secTens, HEX1);
	dec2_7seg d3(minOnes, HEX2);
	dec2_7seg d4(minTens, HEX3);
	
	//test w/o decrementer
	//dec2_7seg d1(initMinsSecs[3:0], HEX0);
	//dec2_7seg d2(initMinsSecs[7:4], HEX1);
	//dec2_7seg d3(initMinsSecs[11:8], HEX2);
	//dec2_7seg d4(initMinsSecs[15:12], HEX3);
	
endmodule