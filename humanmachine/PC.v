//-----------------------------------------------------//
`timescale 1ms/100us
module PC(input clk, input rst, input enable, input [3:0] jmploc, input jmp, output reg [1:0] count1,output reg [1:0]count2);
wire CLK;
parameter delaytime=5;
assign CLK = (clk & enable);
initial begin
    count1 <= 2'b00;
    count2 <= 2'b00;
end
always @(posedge CLK)
begin
    if(rst)
    begin
        #delaytime count1 <= 2'b00;
        #delaytime count2 <= 2'b00;
    end
    else
    begin
        if(count1==2'b11)
        begin
            #delaytime count1 <= 2'b00;
            #delaytime count2 <= count2+1;
        end
        else 
            begin
            #delaytime count1 <= count1+1;
            end
        end
    end
//end
/*
always @(posedge clk)
begin
    if(jmp)
    begin
        count <= jmploc;
    end
end
*/
endmodule



