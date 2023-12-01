// `include "io.sv"

module memory_stage(
	input logic [31:0] pc_next_me,
	input logic [31:0] ALU_res_me,
	input logic [31:0] RU_rs2_me,
	input logic [4:0] rd_me,
	input logic [7:0] switches,
	input logic [2:0] dm_ctrl_me,
	input logic [1:0] RU_DM_write_src_me,
	input logic RUwrite_me,
	input logic dm_wr_me,
	input logic clk_me,
	output logic [31:0] pc_next_wb,
	output logic [31:0] DM_data_rd_wb,
	output logic [31:0] ALU_res_wb,
	output logic [7:0] leds,
	output logic [4:0] rd_wb,	
	output logic RUwrite_wb,
	output logic [1:0] RU_DM_write_src_wb
);


dm_io dm_io(
	.clk(clk_me),
	.DMwre(dm_wr_me),
	.data_write(RU_rs2_me),
	.address(ALU_res_me),
	.switches(switches),
	.leds(leds),
	.DMCtrl_me(dm_ctrl_me),
	.data_read(DM_data_rd_wb)
);

assign pc_next_wb = pc_next_me;
assign rd_wb = rd_me;
assign ALU_res_wb = ALU_res_me;
assign RUwrite_wb = RUwrite_me;
assign RU_DM_write_src_wb = RU_DM_write_src_me;

endmodule