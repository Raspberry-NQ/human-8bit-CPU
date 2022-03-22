`timescale 1ms/100ns
module BUSdelay(input [7:0] I,output [7:0] O);
	parameter delaytime=5;
	assign #delaytime O=I;
endmodule