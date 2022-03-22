`timescale 1ms/100us
`include "CPU.v"

module machine(input start,input clock, output [7:0] BCD,output STOP);
	wire clk;
	assign clk = start ? clock : 1'b0;
	CPU cpu(.clkin(clk), /*output [7:0] OutPut, */.LED(BCD),.HLTO(STOP));

endmodule

