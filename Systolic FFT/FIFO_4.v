module fifo_4(clk,reset,write,delete,fifo_in,error,fifo_out);
input clk,reset,write,delete;
input [7:0] fifo_in;
output reg [7:0] fifo_out;
output reg error;

parameter s0=3'b000,
s1=3'b001,
s2=3'b010,
s3=3'b011,
s4=3'b100,
s5=3'b101,
s6=3'b110,
s7=3'b111;
reg [2:0] state_reg,next_state;
reg [1:0] out_select;
reg write_en;
wire [7:0] r0,r1,r2,r3;

register u0(clk,reset,write_en,fifo_in,r0);

register u1(clk,reset,write_en,r0,r1);
register u2(clk,reset,write_en,r1,r2);

register u3(clk,reset,write_en,r2,r3);

always @(out_select)
	case(out_select)
		2'b00: fifo_out=r0;
		2'b01: fifo_out=r1;
		2'b10: fifo_out=r2;
		2'b11: fifo_out=r3;
		default: fifo_out=0;
	endcase

//state_machine 
always @(posedge clk or posedge reset)
	if(reset)
		state_reg<=s0;
	else 
		state_reg<=next_state;

always @*
	begin
	next_state=0;
	error=0;
	out_select=0;
	write_en=0;
	case(state_reg)
		s0: 
			if(delete)
				begin
				error=1;
				next_state=s0;
				end
			else if(write)
				begin
				write_en=1;
				next_state=s1;
				end
			else
				next_state=s0;
		s1: 
			begin 
				out_select=0;
				if(write)
					if(delete)
						error=1;
					else 
						begin
						write_en=1;
						next_state=s2;
						end
				else if(delete)
					next_state=s0;
				else
					next_state=s1;
			end
		s2: 
			begin
				out_select=1;
				if(write)
					if(delete)
						error=1;
					else 
						begin
						write_en=1;
						next_state=s3;
						end
				else if(delete)
					next_state=s1;
				else 
					next_state=s2;
			end
		s3: 
			begin
				out_select=2;
				if(write)
					if(delete)
						error=1;
					else 
						begin
						write_en=1;
						next_state=s4;
						end
				else if(delete)
					next_state=s2;
				else 
					next_state=s3;
			end		
		s4: 
			begin
				out_select=3;
				if(write)
					
					error=1;
					
				else if(delete)
					next_state=s3;
				else 
					next_state=s4;		
			end
		endcase
		end
endmodule 