module unitDelay    (
output delayed_out     ,  // Output of the delay (1 clock cycle delayed)
input in  ,  // intput to look for edges on
input clk     ,  // clock Input
input reset      // reset Input
);

reg [1:0] state;

//-------------Code Starts Here-------
always @(posedge clk)
begin
	if (reset) begin
	  state <= 2'b00;
	end else begin
	  state[1:0] <= {state[0], in};
	end
end
	
assign delayed_out = state[1]; //output is 1 loop delayed


endmodule 
