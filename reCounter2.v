module reCounter2    (
output reg [1:0] out     ,  // Output of the counter
input enable  ,  // enable for counter
input clk     ,  // clock Input
input reset      // reset Input
);

//-------------Code Starts Here-------
always @(posedge clk)
	if (reset) begin
	  out <= 2'b0 ;
	end else if (enable) begin
	  out <= out + 2'b01;
	end


endmodule 
