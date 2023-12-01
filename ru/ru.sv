module ru(
	input logic clk,
	input logic [4:0] rs1,
	input logic [4:0] rs2,
	input logic [31:0] RUdw,
	input logic [4:0] rd,
	input logic RUwrite,	
	output [31:0] RU1,
	output [31:0] RU2
);
logic [31:0] RU [31:0];

initial begin 
	for (int i = 0; i < 32; i++) begin
	 	RU[i] = 0;
	end
end

always_ff @(posedge clk)
	if(RUwrite)
		RU[rd] = RUdw;
	assign RU1 = RU[rs1];
	assign RU2 = RU[rs2]; 
endmodule