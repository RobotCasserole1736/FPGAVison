module twoToFourDecoder    (
output [3:0]out,  // Output of the decoder
input [1:0]in  // input to the decoder
);

//-------------Code Starts Here-------
reg [3:0] tmp;
always @(*)
	case(in)
		 2'b00: tmp = 4'b0001;
		 2'b01: tmp = 4'b0010;
		 2'b10: tmp = 4'b0100;
		 2'b11: tmp = 4'b1000;
	 endcase
assign out = tmp;
endmodule 
