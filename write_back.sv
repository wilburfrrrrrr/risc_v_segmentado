module write_back_stage(
	input logic [31:0] pc_next_wb,
	input logic [31:0] DM_data_rd_wb,
	input logic [31:0] ALU_res_wb,
	input logic [4:0] rd_wb,
	input logic [1:0] RU_DM_write_src_wb,
	input logic clk_wb,
	input logic RUwrite_wb,	
	output logic [31:0] RU_data_write_wb,
	output logic [4:0] ru_rd_wb,
	output logic RU_write_enable_wb
);

parameter NEXT_PC = 2'b10;
parameter DM_READ = 2'b01;
parameter ALU_RES = 2'b00;

always_ff @(posedge clk_wb) 
	case(RU_DM_write_src_wb)
		NEXT_PC: RU_data_write_wb = pc_next_wb;
		DM_READ: RU_data_write_wb = DM_data_rd_wb;
		ALU_RES: RU_data_write_wb = ALU_res_wb;
		default: RU_data_write_wb = 32'b0;
	endcase

assign RU_write_enable_wb = RUwrite_wb;
assign ru_rd_wb = rd_wb;

endmodule