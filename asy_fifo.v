module asy_fifo (data_out, wr_full, rd_empty, 
				data_in, rd_clk, wr_clk, reset);

parameter WIDTH = 8;
parameter POINTER = 4;
output [WIDTH-1 : 0] data_out;
output wr_full;
output rd_empty;
input [WIDTH-1 : 0] data_in;
input rd_clk, wr_clk;
input reset;

reg [POINTER-1 : 0] rd_pointer, rd_pointer_g, rd_sync_1, rd_pointer_sync;
reg [POINTER-1 : 0] wr_pointer, wr_pointer_g, wr_sync_1, wr_pointer_sync;

parameter DEPTH = 1 << POINTER;

reg [WIDTH-1 : 0] mem [DIPTH-1 : 0];

//--write logic--//
always @(posedge wr_clk or posedge reset) begin
	if (reset) begin
		// reset
		wr_pointer <= 0;
	end
	else if (full == 1'b0) begin
		wr_pointer <= wr_pointer + 1;
		mem[wr_pointer[POINTER-1 : 0]] <= data_in;
	end
end
//--read synchronizer--//
always @(posedge wr_clk) begin
	rd_sync_1 <= rd_pointer_g;
	rd_pointer_sync <= rd_sync_1;
end

assign full  = ((wr_pointer[POINTER-1 : 0] == rd_pointer_sync[POINTER-1 : 0]) && 
				(wr_pointer[POINTER] != rd_pointer_sync[POINTER] ));


//--read logic--//
always @(posedge rd_clk or posedge reset) begin
	if (reset) begin
		// reset
		rd_pointer <= 0;
	end
	else if (empty == 1'b0) begin
		rd_pointer <= rd_pointer + 1;
	end
end

assign data_out <= mem[rd_pointer[POINTER-1 : 0]];

//--write synchronizer--//
always @(posedge rd_clk) begin
	wr_sync_1 <= wr_pointer_g;
	wr_pointer_sync <= wr_sync_1;
end

assign empty = ((wr_pointer_sync == rd_pointer) == 0) ? 1'b1 : 1'b0;

//--gray code--//
always @(wr_pointer) begin
	case (wr_pointer)
	4'b0000: wr_pointer_g = 4'b0000;
	4'b0001: wr_pointer_g = 4'b0001;
	4'b0010: wr_pointer_g = 4'b0011;
	4'b0011: wr_pointer_g = 4'b0010;
	4'b0100: wr_pointer_g = 4'b0110;
	4'b0101: wr_pointer_g = 4'b0111;
	4'b0110: wr_pointer_g = 4'b0101;
	4'b0111: wr_pointer_g = 4'b0100;
	4'b1000: wr_pointer_g = 4'b1100;
	4'b1001: wr_pointer_g = 4'b1101;
	4'b1010: wr_pointer_g = 4'b1111;
	4'b1011: wr_pointer_g = 4'b1110;
	4'b1100: wr_pointer_g = 4'b1010;
	4'b1101: wr_pointer_g = 4'b1011;
	4'b1110: wr_pointer_g = 4'b1010;
	4'b1111: wr_pointer_g = 4'b1000;
end

always @(rd_pointer) begin
	case (rd_pointer)
	4'b0000: rd_pointer_g = 4'b0000;
	4'b0001: rd_pointer_g = 4'b0001;
	4'b0010: rd_pointer_g = 4'b0011;
	4'b0011: rd_pointer_g = 4'b0010;
	4'b0100: rd_pointer_g = 4'b0110;
	4'b0101: rd_pointer_g = 4'b0111;
	4'b0110: rd_pointer_g = 4'b0101;
	4'b0111: rd_pointer_g = 4'b0100;
	4'b1000: rd_pointer_g = 4'b1100;
	4'b1001: rd_pointer_g = 4'b1101;
	4'b1010: rd_pointer_g = 4'b1111;
	4'b1011: rd_pointer_g = 4'b1110;
	4'b1100: rd_pointer_g = 4'b1010;
	4'b1101: rd_pointer_g = 4'b1011;
	4'b1110: rd_pointer_g = 4'b1010;
	4'b1111: rd_pointer_g = 4'b1000;
end

endmodule