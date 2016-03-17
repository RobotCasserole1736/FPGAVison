module sevenBitFourInMux    (
input [6:0]in0,  // mux inputs
input [6:0]in1,  // mux inputs
input [6:0]in2,  // mux inputs
input [6:0]in3,  // mux inputs
input [1:0]sel,  // select line
output [6:0]out  // output from mux
);

//-------------Code Starts Here-------
reg [6:0] tmp;
always @(*)
	case(sel)
		 2'b00: tmp = in0;
		 2'b01: tmp = in1;
		 2'b10: tmp = in2;
		 2'b11: tmp = in3;
	 endcase
assign out = tmp;
endmodule 
