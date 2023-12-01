module alu_tb;
	reg [31:0] A_tb;
	reg [31:0] B_tb;
	reg [3:0] op_tb;
	wire [31:0] out_tb;

	alu dut (
		.A(A_tb),
		.B(B_tb),
		.alu_op(op_tb),
		.alu_out(out_tb)
	);

	initial begin
		$dumpfile("alu.vcd");
		$dumpvars(0, alu_tb);

		A_tb = 32'b10101010101010101010101010101010;
		B_tb = 32'b11001100110011001100110011001100;		
		op_tb = 4'b0000;
		#30
		op_tb = 4'b1000;
		#30
		op_tb = 4'b0001;
		#30
		op_tb = 4'b0101;
		#30
		op_tb = 4'b1101;
		#30
		op_tb = 4'b0010;
		#30
		op_tb = 4'b0011;
		#30
		op_tb = 4'b0111;
		#30
		op_tb = 4'b0110;
		#30
		op_tb = 4'b0100;
		#50
		A_tb = 32'b00000000000000000000000001101010;
		B_tb = 32'b00000000000000000000000000000100;		
		op_tb = 4'b0000;
		#30
		op_tb = 4'b1000;
		#30
		op_tb = 4'b0001;
		#30
		op_tb = 4'b0101;
		#30
		op_tb = 4'b1101;
		#30
		op_tb = 4'b0010;
		#30
		op_tb = 4'b0011;
		#30
		op_tb = 4'b0111;
		#30
		op_tb = 4'b0110;
		#30
		op_tb = 4'b0100;
		#50
		A_tb = 32'b00000000000000001111111111111111;
		B_tb = 32'b00000001111110000000000000000100;		
		op_tb = 4'b0000;
		#30
		op_tb = 4'b1000;
		#30
		op_tb = 4'b0001;
		#30
		op_tb = 4'b0101;
		#30
		op_tb = 4'b1101;
		#30
		op_tb = 4'b0010;
		#30
		op_tb = 4'b0011;
		#30
		op_tb = 4'b0111;
		#30
		op_tb = 4'b0110;
		#30
		op_tb = 4'b0100;
		#50
		A_tb = 32'b00001111111000001111111111111111;
		B_tb = 32'b00000000000000000000001111111000;		
		op_tb = 4'b0000;
		#30
		op_tb = 4'b1000;
		#30
		op_tb = 4'b0001;
		#30
		op_tb = 4'b0101;
		#30
		op_tb = 4'b1101;
		#30
		op_tb = 4'b0010;
		#30
		op_tb = 4'b0011;
		#30
		op_tb = 4'b0111;
		#30
		op_tb = 4'b0110;
		#30
		op_tb = 4'b0100;
		#50
		$finish;
	end
endmodule