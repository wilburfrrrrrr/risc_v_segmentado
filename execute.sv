`include "alu/alu.sv"
`include "bu/bu.sv"

module execute_stage(
	input logic [31:0] pc_next_ex,
	input logic [31:0] pc_ex,
	input logic [31:0] RU_rs2_ex,
	input logic [31:0] mux_a,
	input logic [31:0] mux_b,
	input logic [31:0] imm_ext_ex,
	input logic [4:0] rd_ex,
	input logic [3:0] alu_op_ex,
	input logic [4:0] bu_op_ex,
	input logic [2:0] dm_ctrl_ex,
	input logic [1:0] RU_DM_write_src_ex,
	input logic RUwrite_ex,
	input logic dm_wr_ex,
	input logic alu_a_src_ex,
	input logic alu_b_src_ex,	
	input logic clr,
	input logic clk_ex,
	output logic [31:0] ALU_res,
	output logic [31:0] pc_next_me,
	output logic [31:0] ALU_res_me,
	output logic [31:0] RU_rs2_me,
	output logic [4:0] rd_me,	
	output logic [2:0] dm_ctrl_me,
	output logic [1:0] RU_DM_write_src_me,
	output logic RUwrite_me,
	output logic dm_wr_me,
	output logic next_pc_src_fe,
	output logic clr_de
);

logic [31:0] alu_a;
logic [31:0] alu_b;
logic clr_bu;

logic [3:0] alu_op;
logic [4:0] bu_op;
logic [2:0] dm_ctrl;
logic [1:0] RU_DM_write_src;
logic RUwrite;
logic dm_wr;
logic alu_a_src;
logic alu_b_src;



alu alu(
	.A(alu_a),
	.B(alu_b),
	.alu_op(alu_op),
	.alu_out(ALU_res)
);

bu bu(
	.A(alu_a),
	.B(alu_b),
	.bu_op(bu_op),
	.next_pc_src(next_pc_src_fe),
	.clr(clr_bu),
	.clr_de(clr_de)
);
always_ff @(posedge clk_ex) begin
	if (clr || clr_bu) begin
		alu_op = 0;
		bu_op = 0;
		dm_ctrl = 0;
		RU_DM_write_src = 0;
		RUwrite = 0;
		dm_wr = 0;
		alu_a_src = 0;
		alu_b_src = 0;
	end else begin
		alu_op = alu_op_ex;
		bu_op = bu_op_ex;
		dm_ctrl = dm_ctrl_ex;
		RU_DM_write_src = RU_DM_write_src_ex;
		RUwrite = RUwrite_ex;
		dm_wr = dm_wr_ex;
		alu_a_src = alu_a_src_ex;
		alu_b_src = alu_b_src_ex;
	end

	begin
		pc_next_me = pc_next_ex;
		RU_rs2_me = RU_rs2_ex;
		rd_me = rd_ex;
		dm_ctrl_me = dm_ctrl;
		RU_DM_write_src_me = RU_DM_write_src;
		RUwrite_me = RUwrite;
		dm_wr_me = dm_wr;
		ALU_res_me = ALU_res;
	end 
end

always_ff @(posedge clk_ex)
	begin
		if (alu_a_src) begin
			alu_a = pc_ex;
		end
		else begin
			alu_a = mux_a;
		end
		if (alu_b_src) begin
			alu_b = imm_ext_ex;
		end
		else begin
			alu_b = mux_b;
		end
		// alu_a => (alu_a_src_ex) ? pc_ex : mux_a;
		// alu_b => (alu_b_src_ex) ? imm_ext_ex : mux_b;	
	end



endmodule