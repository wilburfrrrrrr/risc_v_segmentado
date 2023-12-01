`include "hdu/hdu.sv"
`include "fu/fu.sv"

module seg(
	input logic clk,
	input logic [7:0] switches,
	input logic [7:0] leds
);

logic [31:0] pc_fe;
logic [31:0] pc_next;

logic [31:0] pc_next_de;
logic [31:0] pc_de;
logic [31:0] instr;

logic [1:0] mux5;
logic [1:0] mux6;
logic [31:0] rs_a;
logic [31:0] rs_b;

logic [31:0] pc_next_ex;
logic [31:0] pc_ex;
logic [31:0] RU_rs1_ex;
logic [31:0] RU_rs2_ex;
logic [31:0] imm_ext_ex;
logic [4:0] rd_ex;
logic [4:0] rs1_ex;
logic [4:0] rs2_ex;
logic [3:0] alu_op_ex;
logic [4:0] bu_op_ex;
logic [2:0] dm_ctrl_ex;
logic [1:0] RU_DM_write_src_ex;
logic RUwrite_ex;
logic dm_wr_ex;
logic alu_a_src_ex;
logic alu_b_src_ex;
logic [31:0] ALU_res;

logic [31:0] pc_next_me;
logic [31:0] ALU_res_me;
logic [31:0] RU_rs2_me;
logic [4:0] rd_me;
logic [2:0] dm_ctrl_me;
logic [1:0] RU_DM_write_src_me;
logic RUwrite_me;
logic dm_wr_me;
logic next_pc_src_fe;
logic clr;
logic clr_de;
logic enable_fe;
logic enable_de;


logic [31:0] pc_next_wb;
logic [31:0] DM_data_rd_wb;
logic [31:0] ALU_res_wb;
logic [4:0] rd_wb;
logic RUwrite_wb;
logic [1:0] RU_DM_write_src_wb;
logic [31:0] RU_data_write_wb;
logic RU_write_enable_wb;
logic [4:0] ru_rd_wb;


// assign enable_fe = !clr;
// assign enable_de = !clr;

always_ff @(posedge clk) begin 
	if (next_pc_src_fe) begin
		pc_fe = ALU_res_me;
	end
	else begin
		pc_fe = pc_next;
	end

	if(clr) begin
		pc_fe = 0;
	end 

end
	
parameter EX = 2'b00;
parameter ME = 2'b01;
parameter WB = 2'b10;

always_ff @(posedge clk) begin
	case(mux5)
		EX: rs_a = RU_rs1_ex;
		ME: rs_a = ALU_res_me;
		WB: rs_a = RU_data_write_wb;
	endcase
	case(mux6)
		EX: rs_b = RU_rs2_ex;
		ME: rs_b = ALU_res_me;
		WB: rs_b = RU_data_write_wb;
	endcase
end

// always_ff @(posedge clk) begin
// 	if(next_pc_src_fe) begin
// 		pc_fe = ALU_res;
// 	end
// 	else begin
// 		pc_fe = pc_fe + 4;
// 	end
// end

fetch_stage fetch_stage(
	.clk_fe(clk),
	.enable(enable_fe),
	.clr_de(clr_de),
	.pc_fe(pc_fe),
	.pc_next(pc_next),
	.pc_next_de(pc_next_de),
	.pc_de(pc_de),
	.instr(instr)
);

decode_stage decode_stage(
	.instr(instr),
	.pc_de(pc_de),
	.pc_next_de(pc_next_de),
	.dw_wb(RU_data_write_wb),
	.rd_wb(ru_rd_wb),
	.ru_we_wb(RU_write_enable_wb),
	.clk_de(clk),
	.enable(enable_de),
	.pc_next_ex(pc_next_ex),
	.pc_ex(pc_ex),
	.RU_rs1_ex(RU_rs1_ex),
	.RU_rs2_ex(RU_rs2_ex),
	.imm_ext_ex(imm_ext_ex),
	.rd_ex(rd_ex),
	.rs1_ex(rs1_ex),
	.rs2_ex(rs2_ex),
	.alu_op_ex(alu_op_ex),
	.bu_op_ex(bu_op_ex),
	.dm_ctrl_ex(dm_ctrl_ex),
	.RU_DM_write_src_ex(RU_DM_write_src_ex),
	.RUwrite_ex(RUwrite_ex),
	.dm_wr_ex(dm_wr_ex),
	.alu_a_src_ex(alu_a_src_ex),
	.alu_b_src_ex(alu_b_src_ex)
);

hdu hdu(
	.rs1_de(instr[19:15]),
	.rs2_de(instr[24:20]),
	.rd_ex(rd_ex),
	.DMRd_ex(!dm_wr_ex),
	.clk(clk),
	.clr(clr),
	.pc_inc_de(enable_de),
	.pc_fe(enable_fe)
);

execute_stage execute_stage(
	.pc_next_ex(pc_next_ex),
	.pc_ex(pc_ex),
	.RU_rs2_ex(RU_rs2_ex),
	.mux_a(rs_a),
	.mux_b(rs_b),
	.clk_ex(clk),
	.imm_ext_ex(imm_ext_ex),
	.rd_ex(rd_ex),
	.alu_op_ex(alu_op_ex),
	.bu_op_ex(bu_op_ex),
	.dm_ctrl_ex(dm_ctrl_ex),
	.RU_DM_write_src_ex(RU_DM_write_src_ex),
	.RUwrite_ex(RUwrite_ex),
	.dm_wr_ex(dm_wr_ex),
	.alu_a_src_ex(alu_a_src_ex),
	.alu_b_src_ex(alu_b_src_ex),
 	.ALU_res(ALU_res),
	.pc_next_me(pc_next_me),
	.ALU_res_me(ALU_res_me),
	.RU_rs2_me(RU_rs2_me),
	.rd_me(rd_me),
	.dm_ctrl_me(dm_ctrl_me),
	.RU_DM_write_src_me(RU_DM_write_src_me),
	.RUwrite_me(RUwrite_me),
	.dm_wr_me(dm_wr_me),
	.next_pc_src_fe(next_pc_src_fe),
	.clr(clr),
	.clr_de(clr_de)
);

fu fu(
	.rs1_ex(rs1_ex),
	.rs2_ex(rs2_ex),
	.rd_me(rd_me),
	.rd_wb(rd_wb),
	.RUwr_me(RUwrite_me),
	.RUwr_wb(RUwrite_wb),
	.clk(clk),
	.mux5_out(mux5),
	.mux6_out(mux6)
);

memory_stage memory_stage(
	.pc_next_me(pc_next_me),
	.ALU_res_me(ALU_res_me),
	.RU_rs2_me(RU_rs2_me),
	.rd_me(rd_me),
	.switches(switches),
	.dm_ctrl_me(dm_ctrl_me),
	.RU_DM_write_src_me(RU_DM_write_src_me),
	.RUwrite_me(RUwrite_me),
	.dm_wr_me(dm_wr_me),
	.clk_me(clk),
	.pc_next_wb(pc_next_wb),
	.DM_data_rd_wb(DM_data_rd_wb),
	.ALU_res_wb(ALU_res_wb),
	.leds(leds),
	.rd_wb(rd_wb),
	.RUwrite_wb(RUwrite_wb),
	.RU_DM_write_src_wb(RU_DM_write_src_wb)
);

write_back_stage write_back_stage(
	.pc_next_wb(pc_next_wb),
	.DM_data_rd_wb(DM_data_rd_wb),
	.ALU_res_wb(ALU_res_wb),
	.rd_wb(rd_wb),
	.RUwrite_wb(RUwrite_wb),
	.clk_wb(clk),
	.ru_rd_wb(ru_rd_wb),
	.RU_DM_write_src_wb(RU_DM_write_src_wb),
	.RU_data_write_wb(RU_data_write_wb),
	.RU_write_enable_wb(RU_write_enable_wb)
	);

endmodule