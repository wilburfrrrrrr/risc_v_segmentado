module bu (
	input logic [31:0] A,
	input logic [31:0] B,
	input logic [4:0] bu_op,
	// input logic jump_efective,
	output logic clr,
	output logic clr_de,
	output logic next_pc_src
);

parameter no_jump = 5'b00xxx;
parameter eq = 5'b01000;
parameter ne = 5'b01001;
parameter lt = 5'b01100;
parameter ge = 5'b01101;
parameter ltu = 5'b01110;
parameter geu = 5'b01111;
parameter jump = 5'b1xxxx;

always@(*)
	case(bu_op)
		no_jump: next_pc_src = 0;
		eq: next_pc_src = (A == B);
		ne: next_pc_src = (A != B);
		lt: next_pc_src = ($signed(A) < $signed(B));
		ge: next_pc_src = ($signed(A) >= $signed(B));
		ltu: next_pc_src = (A < B);
		geu: next_pc_src = (A >= B);
		jump: next_pc_src = 1;
		default: next_pc_src = 0;
	endcase
	assign clr = next_pc_src;
	assign clr_de = next_pc_src;
endmodule

