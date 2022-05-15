module systolic_fft(clk,reset,xi_real,xi_imag,xj_real,xj_imag,yi_real,yi_imag,yj_real,yj_imag);
input clk,reset;
input [15:0] xi_real,xi_imag,xj_real,xj_imag;
output reg signed [15:0] yi_real,yi_imag,yj_real,yj_imag;
reg signed [15:0] r_real[0:5], r_imag[0:5];
reg [1:0] counter;
wire signed [15:0] w_real[0:3], w_imag[0:3];
// Twiddle factors of three butterflies
wire signed [15:0] w0_real,w0_imag,w1_real,w1_imag,w2_real,w2_imag;
wire sel1,sel2;
wire signed [15:0] yi0_real,yi0_imag,yj0_real,yj0_imag,yi1_real,yi1_imag,yj1_real,yj1_imag,yi2_real,yi2_imag,yj2_real,yj2_imag,
xj1_real,xj1_imag,xj2_real,xj2_imag,out1_real,out1_imag,out2_real,out2_imag;

butterfly u1(xi_real,xi_imag,xj_real,xj_imag,clk,reset,w0_real,w0_imag,yi0_real,yi0_imag,yj0_real,yj0_imag);

butterfly u2(r_real[3],r_imag[3],xj1_real,xj1_imag,clk,reset,w1_real,w1_imag,yi1_real,yi1_imag,yj1_real,yj1_imag);

butterfly u3(r_real[5],r_imag[5],xj2_real,xj2_imag,clk,reset,w2_real,w2_imag,yi2_real,yi2_imag,yj2_real,yj2_imag);

mux2_2 u4(sel1,yi0_real,yi0_imag,r_real[1],r_imag[1],out1_real,out1_imag,xj1_real,xj1_imag);
mux2_2 u5(sel2,yi1_real,yi1_imag,r_real[4],r_imag[4],out2_real,out2_imag,xj2_real,xj2_imag);

assign w0_real=w_real[counter];
assign w0_imag=w_imag[counter];
assign w1_real=w_real[{counter[0],1'b0}];
assign w1_imag=w_imag[{counter[0],1'b0}];
assign w2_real=w_real[counter];
assign w2_imag=w_imag[counter];

always @(posedge clk or posedge reset)
	if(reset)
		begin
		r_real[0]=0;
		r_imag[0]=0;
		r_real[1]=0;
		r_imag[1]=0;
		r_real[2]=0;
		r_imag[2]=0;
		r_real[3]=0;
		r_imag[3]=0;
		r_real[4]=0;
		r_imag[4]=0;
		r_real[5]=0;
		r_imag[5]=0;
		end
	else
		begin		
		r_real[0]=yj0_real;	
		r_imag[0]=yj0_imag;
		r_real[1]=r_real[0];
		r_imag[1]=r_imag[1];
		r_real[2]=out1_real;
		r_imag[2]=out1_imag;
		r_real[3]=r_real[2];
		r_imag[3]=r_imag[2];
		r_real[4]=yj1_real;
		r_imag[4]=yj1_imag;
		r_real[5]=out2_real;
		r_imag[5]=out2_imag;

		end	
	
always @(posedge clk or posedge reset)
if(reset)
counter<=0;
else
counter<=counter+1;
//1,0
assign w_real[0]=16'h4000; 
assign w_imag[0]=16'h0000;
// 0.707, -0.707
assign w_real[1]=16'h2D41;
assign w_imag[1]=16'hD2BF;
// 0, -1
assign w_real[2]=16'h0000;
assign w_imag[2]=16'hC000;
// -0.707, -0.707
assign w_real[3]=16'hD2BF; 
assign w_imag[3]=16'hD2BF;

endmodule