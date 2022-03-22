//----------------------------------------------//
`timescale 1ms/100us
module register8(   input clk,
                    input [7:0] data_in,
                    input EI, 
                    output reg [7:0] data_out);
wire CLK;
parameter delaytime=5;
assign CLK=(clk & EI);
always @(posedge CLK)
begin
    #delaytime data_out[0] <= data_in[0];
    #delaytime data_out[1] <= data_in[1];
    #delaytime data_out[2] <= data_in[2];
    #delaytime data_out[3] <= data_in[3];
    #delaytime data_out[4] <= data_in[4];
    #delaytime data_out[5] <= data_in[5];
    #delaytime data_out[6] <= data_in[6];
    #delaytime data_out[7] <= data_in[7];
end
endmodule