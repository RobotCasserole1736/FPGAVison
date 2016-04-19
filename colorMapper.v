module colorMapper(
	 input [9:0] xDraw,
	 input [9:0] yDraw,
	 input blank, //active low
    output red,
	 output green,
	 output blue
);

reg red_int;
reg green_int;
reg blue_int;

always @(*)
	if (xDraw < 64 && yDraw < 128) begin
	  red_int = 1;
	  green_int = 1;
	  blue_int = 1;
	end else begin
	  red_int = 0;
	  green_int = 0;
	  blue_int = 0;
	end

	
assign red = red_int && blank;
assign green = green_int && blank;
assign blue = blue_int && blank;


endmodule