`include "cu/cu.sv"
`include "ru/ru.sv"
`include "im/im.sv" 
 

module decode_stage(
	input logic [31:0] instr,
	input logic [31:0] pc_de,
	input logic [31:0] pc_next_de,
	input logic [31:0] dw_wb,
	input logic [4:0] rd_wb,
	input logic ru_we_wb,
	input logic clk_de,
	input logic enable,
	output logic [31:0] pc_next_ex,
	output logic [31:0] pc_ex,
	output logic [31:0] RU_rs1_ex,
	output logic [31:0] RU_rs2_ex,
	output logic [31:0] imm_ext_ex,
	output logic [4:0] rd_ex,
	output logic [4:0] rs1_ex,
	output logic [4:0] rs2_ex,
	output logic [3:0] alu_op_ex,
	output logic [4:0] bu_op_ex,
	output logic [2:0] dm_ctrl_ex,
	output logic [1:0] RU_DM_write_src_ex,
	output logic RUwrite_ex,
	output logic dm_wr_ex,
	output logic alu_a_src_ex,
	output logic alu_b_src_ex	
);

logic [2:0] imm_src_de;

cu cu(
	.opcode(instr[6:0]),
	.function3(instr[14:12]),
	.function7(instr[31:25]),
	.alu_op(alu_op_ex),
	.imm_src(imm_src_de),
	.bu_op(bu_op_ex),
	.dm_ctrl(dm_ctrl_ex),
	.RU_DM_write_src(RU_DM_write_src_ex),
	.RUwrite(RUwrite_ex),
	.dm_wr(dm_wr_ex),
	.alu_a_src(alu_a_src_ex),
	.alu_b_src(alu_b_src_ex)
);


im im(
	.imm(instr[31:7]),
	.imm_src(imm_src_de),
	.imm_ext(imm_ext_ex)
);

ru ru(
	.clk(clk_de),
	.rs1(instr[19:15]),
	.rs2(instr[24:20]),
	.RUdw(dw_wb),
	.rd(rd_wb),
	.RUwrite(ru_we_wb),
	.RU1(RU_rs1_ex),
	.RU2(RU_rs2_ex)
);

always_ff @(posedge clk_de) begin 
	if (enable) begin
		pc_next_ex = pc_next_de;
		pc_ex = pc_de;
		rd_ex = instr[11:7];
		rs1_ex = instr[19:15];
		rs2_ex = instr[24:20];
	end
end

endmodule