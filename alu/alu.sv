module alu(
	input logic [31:0] A,
	input logic [31:0] B,
	input logic [3:0] alu_op,
	output logic [31:0] alu_out
);

// alu_op = 0;
// alu_out = 0;

parameter ADD = 4'b0000;
parameter SUB = 4'b1000;
parameter LSL = 4'b0001;
parameter LSR = 4'b0101;
parameter ASR = 4'b1101;
parameter LTS = 4'b0010;
parameter LTU = 4'b0011;
parameter AND = 4'b0111;
parameter OR  = 4'b0110;
parameter XOR = 4'b0100;

always@(*)
case(alu_op)
	ADD: alu_out = A + B;
	SUB: alu_out = A - B;
	LSL: alu_out = A << B;
	LSR: alu_out = A >> B;
	ASR: alu_out = A >>> B;
	LTS: alu_out = ($signed(A) < $signed(B));
	LTU: alu_out = A < B;
	AND: alu_out = A & B;
	OR : alu_out = A | B;
	XOR: alu_out = A ^ B;
	default : alu_out = 0;
endcase
endmodule

