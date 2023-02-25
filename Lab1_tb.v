module bound_flasher_tb;
	reg clk, flick, reset;
	wire[15:0] led;
	bound_flasher inst1(clk, flick, reset, led);
	initial begin
		clk = 1'b0;
		flick = 1'b0;
		reset = 1'b0;
		//straight_cycle_run
		
//		#10 flick = 1'b1;
//		#10 flick = 1'b0;
		
		//kick_back_1
		
//		#10 flick = 1'b1;

		//kick_back_2
		
//		#10 flick = 1'b1;
//		#10 flick = 1'b0;
//		#180 flick = 1'b1;
		
		//kick_back_3
		
//		#10 flick = 1'b1;
//		#10 flick = 1'b0;
//		#180 flick = 1'b1;
//		#400 reset = 1'b1;
//		#10 reset = 1'b0;
		
		//reset
		#10 flick = 1'b1;
		#10 flick = 1'b0;
		#30 reset = 1'b1;

	end
	always #5 clk = ~clk;

//	initial begin
//		$recordfile ("waves");
//		$recordvars ("depth=0", bound_flasher_tb);
//	end
endmodule