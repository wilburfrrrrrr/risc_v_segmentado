module pc(
	input logic clk,
	input logic enable,
	input logic [31:0] pc_in,
	output logic [31:0] pc_out
);

logic [31:0] pc_temp;

always @(posedge clk)
begin
	if(enable)
		pc_temp <= pc_in;
	else
		pc_temp <= pc_temp + 4;
end

assign pc_out = pc_temp;

endmodule