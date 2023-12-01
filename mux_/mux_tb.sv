module mux_tb;
	logic A_tb = 0;
	logic B_tb = 0;
	logic S_tb = 0;
	logic O_tb;

	mux mux1(.A(A_tb), .B(B_tb), .S(S_tb), .O(O_tb));

	initial begin
		$dumpfile("mux_tb.vcd");
		$dumpvars(0, mux_tb);

		#10
		A_tb = 0;
		B_tb = 0;
		S_tb = 0;
		#10
		A_tb = 1;
		B_tb = 1;
		S_tb = 0;
		#10
		A_tb = 1;
		B_tb = 0;
		S_tb = 1;
		#10
		A_tb = 0;
		B_tb = 1;
		S_tb = 1;
		#50
		$finish;
	end

endmodule
//vvp mux
// iverilog -g2012 -o ALU alu.sv alu_tb.sv