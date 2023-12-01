module dm(
	input logic [31:0] data_write,
	input logic [9:0] address,
	input logic [2:0] DMCtrl_me,
	input logic DMwre,
	input logic clk,
	output logic [31:0] data_read
);

logic [31:0] DM [0:1023];

initial begin
	$readmemh("data.txt", DM);
end

parameter b = 3'b001;
parameter bu = 3'b100;
parameter h = 3'b001;
parameter hu = 3'b101;
parameter w = 3'b010;

always@(*)
	if(DMwre)
		case(DMCtrl_me)
			b: 	begin
					DM[address] = $signed(data_write[7:0]);
				end
			h: 	begin
					DM[address] 	= $signed(data_write[15:8]);
					DM[address+1] 	= $signed(data_write[7:0]);
				end
			w: 	begin	
					DM[address] 	= data_write[31:24];
					DM[address+1] 	= data_write[23:16];
					DM[address+2] 	= data_write[15:8];
					DM[address+3] 	= data_write[7:0];
				end
		endcase
	else
		case(DMCtrl_me)
			b: 	data_read = {{24{DM[address][7]}}, DM[address]};
			bu: data_read = {24'b0, DM[address]};
			h: 	data_read = {{16{DM[address][7]}}, DM[address+1], DM[address]};
			bu: data_read = {16'b0, DM[address+1], DM[address]};
			w: 	data_read = {DM[address+3], DM[address+2], DM[address+1], DM[address]};
		endcase
endmodule