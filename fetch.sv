`include "iu/iu.sv"
`include "pc/pc.sv"

module fetch_stage (
	input logic clk_fe,
	input logic enable,
	input logic clr_de,
	input logic [31:0] pc_fe,
	output logic [31:0] pc_next,
	output logic [31:0] pc_next_de,
	output logic [31:0] pc_de,
	output logic [31:0] instr
);

// pc pc(
// 	.clk(clk_fe),
// 	.enable(enable),
// 	.pc_in(pc_fe),
// 	.pc_out(pc_next)
// );

iu iu(
	.instr_address(pc_fe),
	.instr_out(instr)
);
always_ff @(posedge clk_fe) begin
	if (enable) begin
		if(clr_de) begin
			pc_next_de = 0;
		end
		else begin
			pc_next = pc_fe + 4;
			pc_de = pc_fe;
			pc_next_de = pc_next;
		end
	end
	
end
endmodule