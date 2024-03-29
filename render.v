module render (clk, cima, baixo, row, column, saida_galinha, saida_carro, clk2);
	
	/*640 x 480 � a resolu��o do kit*/
	
	input clk, cima, baixo, clk2;
	input [9:0] row, column;
	output reg saida_galinha, saida_carro;
	integer reset = 0;
	integer coluna_galinha = 320; /*column_count*/
	integer linha_galinha = 435; /*row_count*/
	
	/*tr�s linhas de carros*/
	/**/
	integer coluna_carro1 = 600;
	integer linha_carro1 = 60;
	integer coluna_carro1_2 = 300;
	integer linha_carro1_2 = 60;
	
	integer coluna_carro2 = 0;
	integer linha_carro2 = 180;
	
	integer coluna_carro3 = 600;
	integer linha_carro3 = 300;
	
	always @(posedge clk)
	begin
		/*Carro 1 come�a na direita da tela, e se move pra esquerda*/
		/*Velocidade 2*/
		coluna_carro1 = coluna_carro1 - 2;
		if (coluna_carro1 <= 0)
			coluna_carro1 = 640;
			
		/*Carro 1_2 come�a na direita da tela, e se move pra esquerda*/
		/*Velocidade 2*/
		coluna_carro1_2 = coluna_carro1_2 - 2;
		if (coluna_carro1_2 <= 0)
			coluna_carro1_2 = 640;

		/*Carro 2 come�a na esquerda da tela, e se move pra direita*/
		/*Velocidade 3*/
		coluna_carro2 = coluna_carro2 + 3;
		if (coluna_carro2+120 >= 640)
			coluna_carro2 = 0;

		/*Carro 3 come�a na direita da tela, e se move pra esquerda*/
		/*Velocidade 1*/
		coluna_carro3 = coluna_carro3 - 1;
		if (coluna_carro3 <= 0)
			coluna_carro3 = 640;
	end
	
	always @*
	begin
		/*Renderizar Galinha*/
		if(row < linha_galinha + 30 & linha_galinha < row & column < coluna_galinha + 30 & coluna_galinha < column)
			saida_galinha = 1;
		else
			saida_galinha = 0;

		/*Renderizar veiculos*/
		if ((row < linha_carro1 + 60 & linha_carro1 < row & column < coluna_carro1 + 120 & coluna_carro1 < column)
			| (row < linha_carro1_2 + 60 & linha_carro1_2 < row & column < coluna_carro1_2 + 120 & coluna_carro1_2 < column)
			| (row < linha_carro2 + 60 & linha_carro2 < row & column < coluna_carro2 + 120 & coluna_carro2 < column)
			| (row < linha_carro3 + 60 & linha_carro3 < row & column < coluna_carro3 + 120 & coluna_carro3 < column)
			)
			saida_carro = 1;
		else 
			saida_carro = 0;

		/*Tratamento de colis�o*/
		/*Os testes s�o: a esquerda da galinha ou a direita da galinha t�o entre a esquerda ou direita do carro E o topo e a parte de baixo da galinha t�o entre o carro tamb�m ocorre a colis�o*/
		if ((((linha_galinha>=linha_carro1 & linha_galinha<=linha_carro1+60) | (linha_galinha+30 >= linha_carro1 & linha_galinha+30<=linha_carro1+60))
		& ((coluna_galinha>=coluna_carro1 & coluna_galinha<=coluna_carro1+120) | (coluna_galinha+30 >= coluna_carro1 & coluna_galinha+30<=coluna_carro1+120)))
		|
		(((linha_galinha>=linha_carro1_2 & linha_galinha<=linha_carro1_2+60) | (linha_galinha+30 >= linha_carro1_2 & linha_galinha+30<=linha_carro1_2+60))
		& ((coluna_galinha>=coluna_carro1_2 & coluna_galinha<=coluna_carro1_2+120) | (coluna_galinha+30 >= coluna_carro1_2 & coluna_galinha+30<=coluna_carro1_2+120)))
		|
		(((linha_galinha>=linha_carro2 & linha_galinha<=linha_carro2+60) | (linha_galinha+30 >= linha_carro2 & linha_galinha+30<=linha_carro2+60))
		& ((coluna_galinha>=coluna_carro2 & coluna_galinha<=coluna_carro2+120) | (coluna_galinha+30 >= coluna_carro2 & coluna_galinha+30<=coluna_carro2+120)))
		|
		(((linha_galinha>=linha_carro3 & linha_galinha<=linha_carro3+60) | (linha_galinha+30 >= linha_carro3 & linha_galinha+30<=linha_carro3+60))
		& ((coluna_galinha>=coluna_carro3 & coluna_galinha<=coluna_carro3+120) | (coluna_galinha+30 >= coluna_carro3 & coluna_galinha+30<=coluna_carro3+120))))
		
			reset = 1;

		else reset = 0;
	end

	// Controle pra linha galinha
	always @(posedge clk2)
	begin
		if(reset == 1) linha_galinha = 435;
			
		else if(cima == 1) linha_galinha = linha_galinha - 60;
		
		else if(baixo == 1) linha_galinha = linha_galinha + 60;
				
		if(linha_galinha > 435) linha_galinha = 435;
			
		else if(linha_galinha <= 0) linha_galinha = 435;
	end
	
endmodule 