module contador(
	input logic clk,
	input logic D,
	input logic write_enable,
	output logic Q = 0);


	always_ff @( posedge clk ) 
		if(en)
			Q <= D;
		
endmodule