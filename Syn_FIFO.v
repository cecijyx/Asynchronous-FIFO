//--Synchronous FIFO--//
module simple_fifo ()

parameter WIDTH = 8;
parameter DEPTH = 4;

output [WIDTH-1 : 0] data_out;
output full;
output empty;

input [WIDTH-1 : 0] data_in;
input clk;
input reset;

reg [WIDTH-1 : 0] mem [DIPTH-1 : 0];
reg [DEPTH-1 : 0] rd_pointer;
reg [DEPTH-1 : 0] wr_pointer;

assign empty = ((wr_pointer - rd_pointer) == 0) ? 1'b1 : 1'b0;
assign full  = ((wr_pointer - rd_pointer) == DEPTH) ? 1'b1 : 1'b0;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		// reset
		wr_pointer <= 0;
		rd_pointer <= 0;
	end
	else begin
		if (full == 1'b0) begin
			mem[wr_pointer] <= data_in;
			wr_pointer <= wr_pointer + 1;
		end
		if (empty == 1'b0) begin
			data_out <= mem[rd_pointer];
			rd_pointer <= rd_pointer + 1;
		end
	end
end
