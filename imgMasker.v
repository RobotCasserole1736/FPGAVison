module imgMasker(
	 input [9:0] xDraw,
	 input [9:0] yDraw,
	 output inMask
);

//128x256 image

assign inMask = (yDraw[9:7] != 3'b000) || (xDraw[9:6] != 4'b0000);

endmodule