module bound_flasher_tb;
	reg clk, flick, reset;
	wire[15:0] led;
	bound_flasher inst1(clk, flick, reset, led);
	initial begin
		clk = 1'b0;
		flick = 1'b0;
		reset = 1'b0;
		#10 flick = 1'b1;
		#20 flick = 0;
		#170 flick = 1'b1;
		#300 reset = 1'b1;
		#10 reset = 1'b0; 
		//#60 flick = 1'b0;
	end
	always #5 clk = ~clk;

//	initial begin
//		$recordfile ("waves");
//		$recordvars ("depth=0", bound_flasher_tb);
//	end
endmodule