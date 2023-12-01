`include "dm/dm.sv"

module dm_io(
	input logic [31:0] data_write,
	input logic [31:0] address,
	input logic [7:0] switches,
	input logic [2:0] DMCtrl_me,
	input logic DMwre,
	input logic clk,
	output logic [31:0] data_read,
	output logic [7:0] leds
);

logic [9:0] dm_address;
logic dm_wr_e;
logic [31:0] dm_read;
logic led_en;
logic sw_en = 1;

dm dm(
	.data_write(data_write),
	.address(dm_address),
	.DMCtrl_me(DMCtrl_me),
	.DMwre(dm_wr_e),
	.clk(clk),
	.data_read(dm_read)
);

parameter RD = 2'b00;
parameter LD = 2'b01;
parameter SW = 2'b10;

always_ff @( posedge clk ) begin
	dm_address = address[9:0];
	dm_wr_e = DMwre & !address[10] & !address[11];
	led_en = DMwre & address[10] & !address[11];

	leds = 8'b0;

	case(address[11:10])
		RD: data_read = dm_read;
		LD: begin
			if(led_en) begin
				data_read = leds;
			end 
		end
		SW: begin
			if(sw_en) begin
				data_read = switches;
			end
		end 
	endcase
end





endmodule