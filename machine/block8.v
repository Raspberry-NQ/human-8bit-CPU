`timescale 1ms/1ns
module block8(input [7:0] data, input enable, output [7:0] dataOut);
    assign dataOut = enable ? data : 8'bzzzzzzzz;
endmodule