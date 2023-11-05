`timescale 1ns/1ns

/* 
* 	Модуль умножения Бута на 8 Бит
* 	Реализация через сохранение каждой суммы и последующего суммирования
* 	
* 	Не используется блокирующее присваивание
* 	Всегда суммируются все слагаемые
*/ 
module booth_mult_matrix_8_bit (
	input clk,    // Clock
	input signed [7 : 0] num1,
	input signed [7 : 0] num2,

	output signed [7 : 0] res	
);

reg signed [8 : 0] tmp [7 : 0];

integer i;

always @(posedge clk) begin
	if ( num2[0] ) 
		tmp[0] <= (~num1 + 1) << 1;
	else
		tmp[0] <= 0;

	for (i = 1; i < 8; i = i + 1) begin
		if ( num2[i - 1] ^ num2[i] ) 
			if (num2[i - 1]) // A + P
				tmp[i] <= num1 << (i + 1);
			else if (num2[i]) // S + P
				tmp[i] <= (~num1 + 1) << (i + 1);
			else 
				tmp[i] <= 0;
		else
			tmp[i] <= 0;
	end
end

assign res = ((tmp[0] + tmp[1] + tmp[2] + tmp[3] + tmp[4] + tmp[5] + tmp[6] + tmp[7]) & (8'hFF << 1)) >> 1;

endmodule


/* 
* 	Модуль умножения Бута на 8 Бит
* 	Реализация через накопление суммы
*
*	Испоьзуется блокирующее присваивание 
* 	Сумма происходит только со слагаемыми имеющими значение
*/ 
module booth_mult_accum_8_bit	 (
	input clk,    // Clock
	input signed [7 : 0] num1,
	input signed [7 : 0] num2,
	input action,

	output signed [7 : 0] res	
);

reg signed [8 : 0] out = 0;

always @(posedge clk) begin
	if (action == 0)
		out <= 0;
end

integer i;

always @(posedge clk) begin
	if ( num2[0] ) 
		out = out + ( (~num1 + 1) << 1 );

	for (i = 1; i < 8; i = i + 1) begin
		if ( num2[i - 1] ^ num2[i] ) 
			if (num2[i - 1]) // A + P
				out = out + ( num1 << (i + 1) );
			else if (num2[i]) // S + P
				out = out + ( (~num1 + 1) << (i + 1) );
	end
end

assign res = (out & (8'hFF << 1)) >> 1;

endmodule
