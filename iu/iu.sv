module iu (
	input logic [31:0] instr_address,
	output logic [31:0] instr_out
);

logic [31:0] instr_mem [0:1023];
logic [7:0] out1, out2, out3, out4;

initial begin
	$readmemh("iu/iu.txt", instr_mem);
end

always@(*) begin
		out1 = instr_mem[instr_address][7:0];
		out2 = instr_mem[instr_address+1][7:0];
		out3 = instr_mem[instr_address+2][7:0];
		out4 = instr_mem[instr_address+3][7:0];
		instr_out = {out1, out2, out3, out4};
	end
endmodule