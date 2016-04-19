module SerialDataCtrl    (
input clk     ,  // clock Input
input reset ,     // reset Input
input data_in_rx_fifo  ,  // 1 when there is input data to process, 0 otherwise
input tx_busy, //1 when the transmit module is sending, 0 otherwise
input [7:0] rx_data, // input data recieved (as cached by fifo)
input [3:0] pixel_data_in, //input pixel data from pixel memory
output rx_fifo_read, //asserted to read the new byte from FIFO
output tx_start, //1 when tx_data has new data that should start transmitting, 0 otherwise
output [12:0] pixel_memory_read_addr, //memory to read from pixel memory
output reg pixel_memory_read_enable,
output reg [7:0] tx_data, // data to write to the tx fifo 
output reg [7:0] test_data_out //output from the controller - data extracted from input commands. Will eventually be replaced w ith something more meaningful.

);

reg [3:0] state;
reg [13:0] memory_ctr;

//-------------Code Starts Here-------
always @(posedge clk)
begin
	if (reset) begin
	  state <= 4'b0;
	  test_data_out <= 8'b0;
	  memory_ctr <= 13'b0;
	  pixel_memory_read_enable <= 0;
	end else begin
		case(state)
			4'b0000: begin //Idle State
				if(data_in_rx_fifo) state <= 4'b0001;
				else state <= 4'b0000;
				pixel_memory_read_enable <= 0;
			end
			4'b0001: begin //Trigger FIFO to output oldest element
				state <= 4'b0010;
			end
			4'b0010: begin //The byte on the input is the instruction - process accordingly here!
				if(rx_data == 8'h72) begin //command is 'r' - read from memory
					state <= 4'b0011; 
					end
				else state <= 4'b0000; //some other command, discard and reset back to idle
			end
			4'b0011: begin //read from memory
					pixel_memory_read_enable <= 1;
					state <= 4'b0100; 
			end
			4'b0100: begin //get memory's response
				state <= 4'b0101; 
				tx_data <= {4'b0000, pixel_data_in[3:0]};
			end
			4'b0101: begin //Wait for tx module to start transmitting
				if(tx_busy == 1'b1) state <= 4'b0110; 
			end
			4'b0110: begin //Wait for tx module to finish transmitting, then restart back in idel
				if(tx_busy == 1'b0) begin
					if(memory_ctr > 14'b01111111111111) begin
						state <= 4'b0000; 
						memory_ctr <= 14'b00000000000000;
						end
					else begin
						state <= 4'b0011;
						memory_ctr <= memory_ctr + 14'b01;
						end
				end 
			end
			default: state <= 4'b0000; //reset back to idle by default
		endcase
	end
end

//assign non-registered outputs based on state
assign rx_fifo_read = (state==4'b0001);
assign tx_start = (state==4'b0101);
assign pixel_memory_read_addr = memory_ctr[13:0];
	


endmodule 
