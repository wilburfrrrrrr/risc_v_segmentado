module im (
	input logic [24:0] imm,
	input logic [2:0] imm_src,
	output logic [31:0] imm_ext
);

parameter I = 3'b000;
parameter S = 3'b001;
parameter U = 3'b010;
parameter B = 3'b101;
parameter J = 3'b110;

always@(*) 
	case(imm_src)
		I: imm_ext = { {20{imm[24]}}, imm[24:13] };
		S: imm_ext = { {20{imm[24]}}, imm[24:18], imm[4:0] };
		U: imm_ext = { imm[24:5], 12'b0 };
		B: imm_ext = { {20{imm[24]}}, imm[23:18], imm[4:0], 1'b0 };
		J: imm_ext = { {12{imm[24]}}, imm[12:5], imm[13], imm[23:14], 1'b0 };
		default: imm_ext = 32'b0;
	endcase
endmodule