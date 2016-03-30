module clkDiv16    (
output  out     ,  // Output of the clkdiv
input clk     ,  // clock Input
input reset      // reset Input
);


reg [15:0] count;
//-------------Code Starts Here-------
always @(posedge clk)
	if (reset) begin
	  count <= 16'b0 ;
	end else begin
	  count <= count + 16'b0000000000000001;
	end

	assign out = count[15];
endmodule 
