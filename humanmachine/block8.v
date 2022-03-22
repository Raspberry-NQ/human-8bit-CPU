//---------------------------------------------//
`timescale 1ms/100ns
module block8(input [7:0] data, input enable, output [7:0] dataOut);
    parameter delaytime=5;
    assign #delaytime dataOut = enable ? data : 8'bzzzzzzzz;
endmodule