module sevenSegmentDriver(
	 input [3:0]din,
	 input digit_en,
	 input dp, //eventually, this might be controlled by enable?
    output[6:0] segOut,
	 output dp_out
);



reg [6:0] SevenSeg;
always @(*)
if(digit_en)
	case(din)
		 4'h0: SevenSeg = 7'b1111110;
		 4'h1: SevenSeg = 7'b0110000;
		 4'h2: SevenSeg = 7'b1101101;
		 4'h3: SevenSeg = 7'b1111001;
		 4'h4: SevenSeg = 7'b0110011;
		 4'h5: SevenSeg = 7'b1011011;
		 4'h6: SevenSeg = 7'b1011111;
		 4'h7: SevenSeg = 7'b1110000;
		 4'h8: SevenSeg = 7'b1111111;
		 4'h9: SevenSeg = 7'b1111011;
		 4'hA: SevenSeg = 7'b1110111;
		 4'hB: SevenSeg = 7'b0011111;
		 4'hC: SevenSeg = 7'b1001110;
		 4'hD: SevenSeg = 7'b0111101;
		 4'hE: SevenSeg = 7'b1001111;
		 4'hF: SevenSeg = 7'b1000111;
		 default: SevenSeg = 7'b0000000;
	endcase
else
	SevenSeg = 7'b0000000;

assign segOut = SevenSeg[6:0];
assign dp_out = dp;
endmodule