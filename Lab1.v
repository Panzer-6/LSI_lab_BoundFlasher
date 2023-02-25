module bound_flasher(clk, flick, reset, led_out);
	input clk, flick, reset;
	reg[0:2] state;
	reg rollBack;
	output reg[15:0] led_out;
	
	initial led_out = 0;
	initial state = 0;
	initial rollBack = 0;
	
	always@(led_out or reset or flick) begin
		if (reset) begin
			state <= 0;
			rollBack <= 0;
		end
		else begin
			case (state)
				0: begin //Initial
					if (flick) begin
						state <= 1;
					end
				end
				1: begin //Turn on from 0 -> 5
					if (led_out == 16'b0000000000111111) begin
						if (flick) rollBack <= 1;
						state <= 2;
					end
				end
				2: begin //Turn off from 5 -> 0
					if (led_out == 16'b0000000000000000) begin
						if (rollBack) begin
							state <= 1;
							rollBack <= 0;
						end
						else begin
							state <= 3;
						end
					end
				end
				3: begin //Turn on from 0 -> 10
					if (led_out == 16'b0000011111111111) begin
						if (flick) rollBack <= 1 ;
						state <= 4;
					end
				end
				4: begin //Turn off from 10 -> 5
					if (led_out == 16'b0000000000111111) begin
						if (rollBack) begin
							state <= 7;
							rollBack <= 0;
						end
						else begin 
							state <= 5;
						end
					end
				end
				5: begin //Turn on from 5 -> 15
					if (led_out == 16'b1111111111111111) begin
						state <= 6;
					end
				end
				6: begin 
					if (led_out == 16'b0000000000000000) begin
						state <= 0;
					end
				end
				7: begin //Turn on from 5 -> 10
					if (led_out == 16'b0000011111111111) begin
						if (flick) begin
							rollBack <= 1;
							state <= 4;
						end
						else begin
							state <= 6;
						end
					end
				end
				default: state <= 0;
			endcase
		end
	end
	
	always@(posedge clk or posedge reset) begin
			if (reset) led_out <= 16'b0000000000000000;
			else begin
				case (state)
					1, 3, 5, 7: led_out <= (led_out <<< 1) + 16'b0000000000000001;
					2, 4, 6: led_out <= (led_out >>> 1);
				endcase
			end
	end
endmodule
		