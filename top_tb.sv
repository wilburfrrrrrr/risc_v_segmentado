`timescale 1ns/1ps

module test;

logic clk_tb;
logic [7:0] switches_tb;
logic [7:0] leds_tb;

top top(.clk_p(clk_tb), .switches_p(switches_tb), .leds_p(leds_tb));

initial clk_tb = 0;
initial switches_tb = 1'b00000000;
always #5 clk_tb = ~clk_tb;

initial begin
		$dumpfile("enguaduado.vcd");
		$dumpvars(0, test);

		#50 $finish;
	end

endmodule