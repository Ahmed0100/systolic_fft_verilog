module register(clk,reset,write,data_in,data_out);
input clk,reset,write;
input [7:0] data_in;
output reg [7:0] data_out;
always @(posedge clk or posedge reset)
	if(reset)
		data_out<=0;
	else if(write)
		data_out<=data_in;
	else 
		data_out=data_out;
	
endmodule 