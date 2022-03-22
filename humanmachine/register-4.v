//----------------------------------------------//
`timescale 1ms/100us
module register4(input clk, input [3:0] data_in, input EI, output reg [3:0] data_out);
wire CLK;
parameter delaytime=5;
assign CLK=(clk & EI);
always @(posedge CLK)
begin
    #delaytime data_out[0] <= data_in[0];
    #delaytime data_out[1] <= data_in[1];
    #delaytime data_out[2] <= data_in[2];
    #delaytime data_out[3] <= data_in[3];
end
endmodule