module ru_tb;
	logic clk_tb = 0;
	logic RUwrite_tb = 0;
	logic [4:0] rs1_tb;
	logic [4:0] rs2_tb;
	logic [4:0] rd_tb;
	logic [31:0] RUdw_tb;
	logic [31:0] RU1_tb;
	logic [31:0] RU2_tb;
	logic [31:0] RU_tb [31:0];

	ru dut(.clk(clk_tb), .RUwrite(RUwrite_tb), .rs1(rs1_tb), .rs2(rs2_tb), .rd(rd_tb), .RUdw(RUdw_tb), .RU1(RU1_tb), .RU2(RU2_tb));

	always #10 clk_tb = ~clk_tb; 
	always #20 RUwrite_tb = ~RUwrite_tb;

	initial begin
		$dumpfile("ru.vcd");
		$dumpvars(0, ru_tb);
		clk_tb = 0;
		RUwrite_tb = 0;
		rs1_tb = 0;
		rs2_tb = 0;
		rd_tb = 0;
		RUdw_tb = 32'b0;
		#20
		rd_tb = 5'b10101;
		RUdw_tb = 32'b10101010101010101010101010010101;
		#20
		rd_tb = 5'b10010;
		RUdw_tb = 32'b11110101011001011111101010010101;
		#20
		rs1_tb = 5'b10101;
		rs2_tb = 5'b10010;
		#20
		$finish;
		end
endmodule
