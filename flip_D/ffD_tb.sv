module ff_tb;
	logic clk_tb = 0;
	logic write_enable_tb = 0;
	logic D_tb = 0;
	logic Q_tb;

	ffD ff1(.clk(clk_tb), .write_enable(write_enable_tb), .D(D_tb), .Q(Q_tb));

	always #10 clk_tb = !clk_tb;

	initial begin
		$dumpfile("ff.vcd");
		$dumpvars(0, ff_tb);

		#10
		write_enable_tb = 1;
		D_tb = 1;
		#10
		write_enable_tb = 0;
		D_tb = 0;
		#10
		write_enable_tb = 1;
		#10
		write_enable_tb = 0;
		#500
		$finish;
	end

endmodule
//iverilog -g2012 -o mux -c mux_files.txt
//vvp mux
