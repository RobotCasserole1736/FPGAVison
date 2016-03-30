module SerialDataCtrl    (
input clk     ,  // clock Input
input reset ,     // reset Input
input data_in_rx_fifo  ,  // 1 when there is input data to process, 0 otherwise
input tx_busy, //1 when the transmit module is sending, 0 otherwise
input [7:0] rx_data, // input data recieved (as cached by fifo)
output rx_fifo_read, //asserted to read the new byte from FIFO
output tx_start, //1 when tx_data has new data that should start transmitting, 0 otherwise
output reg [7:0] tx_data, // data to write to the tx fifo 
output reg [7:0] test_data_out //output from the controller - data extracted from input commands. Will eventually be replaced w ith something more meaningful.

);

reg [3:0] state;

//-------------Code Starts Here-------
always @(posedge clk)
begin
	if (reset) begin
	  state <= 4'b0;
	  test_data_out <= 8'b0;
	end else begin
		case(state)
			4'b0000: begin //Idle State
				if(data_in_rx_fifo) state <= 4'b0001;
				else state <= 4'b0000;
			end
			4'b0001: begin //Trigger FIFO to output oldest element
				state <= 4'b0010;
			end
			4'b0010: begin //The byte on the input is the instruction - process accordingly here!
				test_data_out <= rx_data; //test, just report instruction to display
				tx_data <= rx_data + 1; //test, apply transformation to data and tx it back to the PC
				state <= 4'b0011;
			end
			4'b0011: begin //The data on the output is ready to be sent to the tx module, clock it to there.
				state <= 4'b0100; 
			end
			4'b0100: begin //Wait for tx module to start transmitting
				if(tx_busy == 1'b1) state <= 4'b0101; 
			end
			4'b0101: begin //Wait for tx module to finish transmitting, then restart back in idel
				if(tx_busy == 1'b0) state <= 4'b0000; 
			end
			default: state <= 4'b0000; //reset back to idle by default
		endcase
	end
end

//assign non-registered outputs based on state
assign rx_fifo_read = (state==4'b0001);
assign tx_start = (state==4'b0011);
	


endmodule 
