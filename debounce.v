//fpga4student.com
// FPGA projects, Verilog projects, VHDL projects
// Verilog code for button debouncing on FPGA
// debouncing module 
// https://www.fpga4student.com/2017/04/simple-debouncing-verilog-code-for.html

module debounce(input pb_1,clk,output pb_out);
	wire slow_clk;
	wire Q1, Q2, Q2_bar;

	clock_div u1(clk,slow_clk);
	my_dff d1(slow_clk, pb_1,Q1);
	my_dff d2(slow_clk, Q1,Q2);

	assign Q2_bar = ~Q2;
	assign pb_out = Q1 & Q2_bar;
endmodule

// Slow clock for debouncing 
// input clk = 25.175 MHz; output clk = 400 Hz
module clock_div(input Clk_25M, output reg slow_clk);
    reg [15:0] counter = 16'd0;
    always@(posedge Clk_25M)
    begin
        counter <= (counter >= 16'd62_937)? 16'd0 : counter + 16'd1;
        slow_clk <= (counter < 16'd31_469)? 1'b0 : 1'b1;
    end
endmodule

// D-flip-flop for debouncing module 
module my_dff(input DFF_CLOCK, D, output reg Q);

    always @ (posedge DFF_CLOCK) begin
        Q <= D;
    end

endmodule