module galinha (clk, nrst, column_updown, column_en, row_updown, row_en, row, column, s);
	
	input clk, nrst, column_updown, column_en, row_updown, row_en;
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
		else if(column_en == 1)
			if(column_updown == 1)
				column_count = column_count + 1;
			else if(column_updown == 0)
				column_count = column_count - 1;
				
		if(column_count == 640)
			column_count = 0;
		else if(column_count == -1)
			column_count = 0;
	end
	
	// Control for row counter
	always @(posedge clk)
	begin
		if(nrst == 0)
			row_count = 0;
		else if(row_en == 1)
			if(row_updown == 1)
				row_count = row_count + 1;
			else if(row_updown == 0)
				row_count = row_count - 1;
				
		if(row_count == 480)
			row_count = 0;
		else if(row_count == -1)
			row_count = 0;
	end
	
endmodule 

/*
	4'b0011 FRENTE
	4'b1100 BAIXO
	4'b0001 TRAS
	4'b0100 CIMA
*/