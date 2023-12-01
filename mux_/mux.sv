module mux(
	input logic A,
	input logic B,
	input logic S,
	output logic O);


always_comb 
	if (S) 
		O = A;
	else
		O = B;

endmodule
