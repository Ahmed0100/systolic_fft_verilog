module butterfly(xi_real,xi_imag,xj_real,xj_imag,clk,reset,w_real,w_imag,yi_real,yi_imag,yj_real,yj_imag);
input [15:0] xi_real,xi_imag,xj_real,xj_imag,w_real,w_imag;
input clk,reset;
output wire signed [15:0] yi_real,yi_imag,yj_real,yj_imag;

wire signed [16:0] tempi_real,tempi_imag,tempj_real,tempj_imag;
wire signed [31:0] mul_real,mul_imag;
assign tempi_real=xi_real+xj_real;
assign tempi_imag=xi_imag+xj_imag;
assign tempj_real=xi_real-xj_real;
assign tempj_imag=xi_imag-xj_imag;
assign mul_real=tempj_real*w_real-tempj_imag*w_imag;
assign mul_imag=tempj_real*w_imag+tempj_imag*w_real;
assign yi_real=tempi_real>>1;
assign yi_imag=tempi_imag>>1;
assign yj_real=mul_real[31:16];
assign yj_imag=mul_imag[31:16];
endmodule 