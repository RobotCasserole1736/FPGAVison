module REdetect    (
output re     ,  // Output of the detector (1 on rising edges)
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
	
assign re = state[0] && !state[1]; //postivie edge is when present signal is high but previous was low.


endmodule 
