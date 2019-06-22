module carro1 (clk, nrst, row, column, s);
	
	input clk, nrst;
	input [9:0] row, column;
	output reg s;
	integer column_count = 0;
	integer row_count = 0;
	
	always @*
	begin
		if(row < row_count + 30 & row_count < row & column < column_count + 30 & column_count < column)
			s = 1;
		else
			s = 0;
	end
	
	// Control for column counter
	always @(posedge clk)
	begin
		if(nrst == 0)
			column_count = 0;
		else
			column_count = column_count + 1;
				
		if(column_count == 640)
			column_count = 0;
	end
	
endmodule 