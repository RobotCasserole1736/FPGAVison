module camSccbClk(
	input clk_i, 
	input rst_i, 
	output reg sccb_clk );
	
   parameter IN_FREQ = 50_000_000; // clk_i frequency in Hz.
   localparam  SCCB_FREQ = 100_000;    // SCCB frequency in Hz.
   localparam  T_SREG = 300;           // Register setup time in ms. 300ms for OV7670.

   localparam  integer SREG_CYCLES = (IN_FREQ/1000)*T_SREG;   
   localparam  SCCB_PERIOD = IN_FREQ/SCCB_FREQ/2;

   reg  [clog2(SCCB_PERIOD):0] sccb_clk_cnt = 0;

   // Generate clock for the SCCB.
   always @(posedge clk_i or negedge rst_i) begin
      if (rst_i == 0) begin
         sccb_clk_cnt <= 0;
         sccb_clk <= 0;
      end else begin
         if (sccb_clk_cnt < SCCB_PERIOD) begin
            sccb_clk_cnt <= sccb_clk_cnt + 1;
         end else begin
            sccb_clk <= ~sccb_clk;
            sccb_clk_cnt <= 0;
         end
      end
   end

	
function integer clog2;
   input integer value;
   
   begin  
      value = value-1;
      for (clog2=0; value>0; clog2=clog2+1)
         value = value>>1;
   end  
   
endfunction

endmodule

