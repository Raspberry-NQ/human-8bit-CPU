`timescale 1ns/1ps
module register4(input clk, input [3:0] data_in, input EI, output reg [3:0] data_out);
wire CLK;
assign CLK=(clk & EI);
always @(posedge CLK)
begin
    data_out <= data_in;
end
endmodule