// 4-State Mealy state machine

// A Mealy machine has outputs that depend on both the state and 
// the inputs.  When the inputs change, the outputs are updated
// immediately, without waiting for a clock edge.  The outputs
// can be written more than once per state or per clock cycle.

module mealy_mac
(
	input	clk, cima, baixo,
	output reg [2:0] data_out
);

	// Declare state register
	reg		[2:0]state;
	
	// Declare states
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;
	
	// Determine the next state synchronously, based on the
	// current state and the input
	always @ (state) begin
		case (state)
			//parado
			S0:
				data_out = 4'b0001;
			//cima
			S1:
				data_out = 4'b0010;
			//baixo
			S2:
				data_out = 4'b0011;
			//dont care
			S3:
				data_out = 4'b0001;
			default:
				data_out = 4'b0001;
		endcase
	end
	
	// Determine the output based only on the current state
	// and the input (do not wait for a clock edge).
	always @ (posedge clk)
	begin
		if (cima)
			state <= S1;
		else if (baixo)
			state <= S2;
		else 
			state <= S0;
	end
endmodule
