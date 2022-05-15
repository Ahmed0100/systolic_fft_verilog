module mux2_2(sel,xi_real,xi_imag,xj_real,xj_imag,yi_real,yi_imag,yj_real,yj_imag);
input sel;
input [15:0] xi_real,xi_imag,xj_real,xj_imag;
output reg signed [15:0] yi_real,yi_imag,yj_real,yj_imag ;

always @*
	if(sel)
		begin
		yi_real=xj_real; yi_imag=xj_imag; 
		yj_real=xi_real; yj_imag=xi_imag;
		end
	else 
		begin
		yi_real=xi_real; yi_imag=xi_imag; 
		yj_real=xj_real; yj_imag=xj_imag;
		end	
endmodule 