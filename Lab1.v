module bound_flasher(clk, flick, led_out);
	input clk, flick;
	reg[0:3] state;
	reg rollBack;
	output reg[0:15] led_out;
	initial led_out = 0;
	initial state = 0;
	initial rollBack = 0;
	always@(posedge clk) begin
		case (state)
			0: begin //Initial
				if (flick) begin
					led_out <= 16'b1000000000000000;
					state <= 1;
				end
			end
			1: begin //Turn on from 0 -> 5
				led_out <= (led_out >>> 1) + 16'b1000000000000000;
				if (led_out == 16'b1111100000000000) begin
					if (flick) rollBack <= 1;
					state <= 2;
				end
			end
			2: begin //Turn off from 5 -> 0
				led_out <= (led_out <<< 1);
				if (led_out == 16'b0000000000000000) begin
					if (rollBack) begin
						state <= 1;
						rollBack <= 0;
					end
					else state <= 3;
				end
			end
			3: begin //Turn on from 0 -> 10
				led_out <= (led_out >>> 1) + 16'b1000000000000000;
				if (led_out == 16'b1111111111000000) begin
					if (flick) rollBack <= 1 ;
					state <= 4;
				end
			end
			4: begin //Turn off from 10 -> 5
				led_out <= (led_out <<< 1);
				if (led_out == 16'b1111110000000000) begin
					if (rollBack) begin
						state <= 7;
						rollBack <= 0;
					end
					else state <= 5;
				end
			end
			5: begin //Turn on from 5 -> 15
				led_out <= (led_out >>> 1) + 16'b1000000000000000;
				if (led_out == 16'b1111111111111111) begin
					state <= 6;
				end
			end
			6: begin 
				led_out <= (led_out <<< 1);
				if (led_out == 16'b0000000000000000) begin
					state <= 0;
				end
			end
			7: begin //Turn on from 5 -> 10
				led_out <= (led_out >>> 1) + 16'b1000000000000000;
				if (led_out == 16'b1111111111000000) begin
					if (flick) begin
						rollBack <= 1;
						state <= 4;
					end
					else state <= 6;
				end
			end
			default: state <= 0;
		endcase
	end
endmodule
		