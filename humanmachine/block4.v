//---------------------------------------------//
`timescale 1ms/100ns
module block4(input [3:0] data, input enable, output [3:0] dataOut);
    parameter delaytime=5;
    assign #delaytime dataOut = enable ? data : 4'bzzzz;
endmodule