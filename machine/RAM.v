`timescale 1ms/1ns
module RAM(input clk, input [3:0] address, input write_enable, input read_enable, inout [7:0] data);
reg [7:0] Memory[15:0];
reg [7:0] buffer;
/*
LDA 14      0
LDB 15      1
PLUSTOB     2
LDA 15      3
PLUSTOA     4
ATORAM 13   5
LDA 13      6
LDB 14      7
SUBTOA      8
ATODIS      9
POWEROFF    10
            11
            12
            13
10101010    14
01010101    15
*/
initial begin
    Memory[0] <= 8'b0001_1110;
    Memory[1] <= 8'b0010_1111;
    Memory[2] <= 8'b0100_0000;
    Memory[3] <= 8'b0001_1111;
    Memory[4] <= 8'b0011_0000;
    Memory[5] <= 8'b0111_1101;
    Memory[6] <= 8'b0001_1101;
    Memory[7] <= 8'b0010_1110;
    Memory[8] <= 8'b0011_0000;
    Memory[9] <= 8'b1001_0000;
    Memory[10] <= 8'b1010_0000;
    Memory[11] <= 8'b0000_0010;
    Memory[12] <= 8'b0000_0001;
    Memory[13] <= 8'b0000_0101;
    Memory[14] <= 8'b10101010;
    Memory[15] <= 8'b01010101;
end


always @(posedge clk)
begin
    if(write_enable & ~read_enable)
    begin
        Memory[address] <= data;
    end
    else
    begin
        buffer <= Memory[address];
    end
end

assign data = (read_enable & ~write_enable) ? buffer : 8'bzzzzzzzz;

endmodule