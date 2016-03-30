module clkDiv16    (
output  out     ,  // Output of the clkdiv
input clk     ,  // clock Input
input reset      // reset Input
);


reg [16:0] count;
//-------------Code Starts Here-------
always @(posedge clk)
	if (reset) begin
	  count <= 8'b0 ;
	end else begin
	  count <= count + 1;
	end

	assign out = count[15];
endmodule 
