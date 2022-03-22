`timescale 1ms/1ps
module register8(   input clk,
                    input [7:0] data_in,
                    input EI, 

                    output reg [7:0] data_out);
wire CLK;
assign CLK=(clk & EI);
always @(posedge CLK)
begin
    data_out <= data_in;
end
endmodule