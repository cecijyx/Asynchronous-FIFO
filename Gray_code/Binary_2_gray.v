//-- 4 bit Binary code to Gray code converter--//
//-- Reference from--//
//-- (http://verilogbynaresh.blogspot.com/2013/07/binary-to-gray-code-converter-using.html)--//

module Binary_to_Gray (dout, din);

output [3:0] dout ;

input [3:0] din ;
//--solution 1--//
/*
assign dout[3] = din[3];
assign dout[2] = din[3]^din[2];
assign dout[1] = din[2]^din[1];
assign dout[0] = din[1]^din[0];
*/

//-- solution 2--//
assign dout = din ^ (din >>1);

//--solution 3--//
/*
always @(din) begin
	case (din)
	4'b0000: dout = 4'b0000;
	4'b0001: dout = 4'b0001;
	4'b0010: dout = 4'b0011;
	4'b0011: dout = 4'b0010;
	4'b0100: dout = 4'b0110;
	4'b0101: dout = 4'b0111;
	4'b0110: dout = 4'b0101;
	4'b0111: dout = 4'b0100;
	4'b1000: dout = 4'b1100;
	4'b1001: dout = 4'b1101;
	4'b1010: dout = 4'b1111;
	4'b1011: dout = 4'b1110;
	4'b1100: dout = 4'b1010;
	4'b1101: dout = 4'b1011;
	4'b1110: dout = 4'b1001;
	4'b1111: dout = 4'b1000;
end
*/
endmodule