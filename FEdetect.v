module FEdetect    (
output fe     ,  // Output of the detector (1 on falling edges)
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
	
assign fe = !state[0] && state[1]; //falling edge is when present signal is low but previous was high.


endmodule 
