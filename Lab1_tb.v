module bound_flasher_tb;
	reg clk, flick;
	wire[0:15] led;
	bound_flasher inst1(clk, flick, led);
	initial begin
		clk = 1'b0;
		flick = 1'b0;
		#10 flick = 1'b1;
		#20 flick = 0;
		#200 flick = 1'b1;
		//#60 flick = 1'b0;
	end
	always #5 clk = ~clk;

//	initial begin
//		$recordfile ("waves");
//		$recordvars ("depth=0", bound_flasher_tb);
//	end
endmodule