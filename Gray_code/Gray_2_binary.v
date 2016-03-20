//-- 4 bit Gray code to Binary code converter--//
//--Reference from--//
//--(http://verilogbynaresh.blogspot.com/2013/07/design-of-gray-to-binary-code-converter.html)--//

module Gray_to_Binary (dout, din);

output [3:0] dout ;

input [3:0] din ;
//--solution 1-//
/*
assign dout[3] = din[3];
assign dout[2] = din[3]^din[2];
assign dout[1] = din[3]^din[2]^din[1];
assign dout[0] = din[3]^din[2]^din[1]^din[0];
*/

//--solution 2--//
/*
assign dout = din ^ (din >> 1) ^ (din >> 2) ^ (din >>3);
*/

//--solution 3--//
//--save more space--//
always @(din) begin : 
	dout[3] = din[3];
	for (int i = 1; i < 3; i++) begin
		dout[i-1] = din[i-1] ^ dout[i];
	end
end
//--solution 4--//
/*
always @(din) begin
	case (din)
	4'b0000: dout = 4'b0000;
	4'b0001: dout = 4'b0001;
	4'b0011: dout = 4'b0010;
	4'b0010: dout = 4'b0011;
	4'b0110: dout = 4'b0100;
	4'b0111: dout = 4'b0101;
	4'b0101: dout = 4'b0110;
	4'b0100: dout = 4'b0111;
	4'b1100: dout = 4'b1000;
	4'b1101: dout = 4'b1001;
	4'b1111: dout = 4'b1010;
	4'b1110: dout = 4'b1011;
	4'b1010: dout = 4'b1100;
	4'b1011: dout = 4'b1101;
	4'b1001: dout = 4'b1110;
	4'b1000: dout = 4'b1111;
end
*/
endmodule