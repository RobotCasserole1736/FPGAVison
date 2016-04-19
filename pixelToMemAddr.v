module pixelToMemAddr(
	 input [9:0] xDraw,
	 input [9:0] yDraw,
	 output [12:0] memAddr
);

assign memAddr = {yDraw[6:0], xDraw[5:0]}; //64x128 picture
endmodule