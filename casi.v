module casi(
			input clk,     //�������� ��������
			output reg blink,  // ������� ������� ��� � �������
			output reg [7:0] chislo,  // �������� ������� ����� �����
			output reg [3:0] razriad); // �������� ������� ��� ����� �������
/*
1 = 01000100
2 = 10011101
3 = 11010101
4 = 11000110
5 = 11010011
6 = 11011011
7 = 01000101
8 = 11011111
9 = 11000111
0 = 01011111
*/			
reg [4:0]timer;        //������� ��� ������������ ���������
reg [25:0]timer2;	   //������� ����� ������
reg [5:0]minuta;	   //������� 60-�� �����
reg [7:0]chisla[0:9];  //������ ���� ���� ����������
reg [3:0]chet1;		   //������� ��� ������ �����
reg [3:0]chet2;
reg [3:0]chet3;
reg [3:0]chet4;		   //�������� ��� ����� �����
reg blinkk;  			// ������� ������� ��� � �������
initial begin          // ������ � ������ ���� ����
	chisla[0] = 8'b01011111;     
	chisla[1] = 8'b01000100;
	chisla[2] = 8'b10011101;
	chisla[3] = 8'b11010101;
	chisla[4] = 8'b11000110;
	chisla[5] = 8'b11010011;
	chisla[6] = 8'b11011011;
	chisla[7] = 8'b01000101;
	chisla[8] = 8'b11011111;
	chisla[9] = 8'b11000111;
	chet1 = 0;       // ��������� �������
	chet2 = 4;
	chet3 = 2;
	chet4 = 1;
end

always @(posedge clk) begin    // ���� ������������ ���������
	timer <= timer + 1'd1;
	if (timer < 5) begin          // ������ ������ �����
		chislo = chisla[chet1];
		blink = 0;
		razriad = 4'b0111;
	end
	if (timer > 5 && timer <= 10) begin
		chislo = chisla[chet2];
		blink = 0;
		razriad = 4'b1011;
	end
	if (timer > 10 && timer <= 15) begin
		chislo = chisla[chet3];
		blink = blinkk;
		razriad = 4'b1101;
	end
	if (timer > 15 && timer < 20) begin   // ������ ����� �����
		chislo = chisla[chet4];
		blink = 0;
		razriad = 4'b1110;
	end
	if (timer == 21)
		timer <= 0;
end	

always @(posedge clk) begin    //���� ���������� �������
	timer2 <= timer2 + 1'd1;
	if (timer2 == 50000000) begin
		blinkk <= ~blinkk;
		minuta = minuta + 1'b1;
	end
		
	if (minuta == 60) begin
		minuta = 0;
		chet1 = chet1 + 1'd1;
	end
	
	if (chet1 == 10) begin
		chet1 = 0;
		chet2 = chet2 + 1'b1;
	end
	
	if (chet2 == 6) begin
		chet2 = 0;
		chet3 = chet3 + 1'b1;
	end
	
	if (chet3 == 10) begin
		chet3 = 0;
		chet4 = chet4 + 1'b1;
	end
	
	if (chet4 == 3) begin
		chet4 = 0;
	end
		
		
	if (timer2 == 50000000)
		timer2 <= 0;
end
		
endmodule