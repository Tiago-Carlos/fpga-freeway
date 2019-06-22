module input_synchronizer(input clk, async_input, output reg sync_output);

	reg sync_reg;
	
	always @ (posedge clk) begin
		sync_reg <= async_input;
		sync_output <= sync_reg;
	end

endmodule 