//-----------------------------------------------------//
`timescale 1ms/100us
module RAM(input clk, input [3:0] address, input write_enable, input read_enable, inout [7:0] data);
reg [7:0] Memory[15:0];
reg [7:0] buffer;
parameter delaytime =5;
initial begin
    Memory[0] <= 8'b0001_1010;
    Memory[1] <= 8'b0010_1011;
    Memory[2] <= 8'b0100_0110;
    Memory[3] <= 8'b0011_1100;
    Memory[4] <= 8'b0010_1101;
    Memory[5] <= 8'b1110_0000;
    Memory[6] <= 8'b0001_1110;
    Memory[7] <= 8'b0010_1111;
    Memory[8] <= 8'b1110_0000;
    Memory[9] <= 8'b1111_0000;
    Memory[10] <= 8'b0000_0011;
    Memory[11] <= 8'b0000_0010;
    Memory[12] <= 8'b0000_0001;
    Memory[13] <= 8'b0000_0101;
    Memory[14] <= 8'b0000_1010;
    Memory[15] <= 8'b0000_1011;
end


always @(posedge clk)
begin
    if(write_enable & ~read_enable)
    begin
        #delaytime Memory[address][0] <= data[0];
        #delaytime Memory[address][1] <= data[1];
        #delaytime Memory[address][2] <= data[2];
        #delaytime Memory[address][3] <= data[3];

        #delaytime Memory[address][4] <= data[4];
        #delaytime Memory[address][5] <= data[5];
        #delaytime Memory[address][6] <= data[6];
        #delaytime Memory[address][7] <= data[7];
    end
    else
    begin
        #delaytime buffer[0] <= Memory[address][0];
        #delaytime buffer[1] <= Memory[address][1];
        #delaytime buffer[2] <= Memory[address][2];
        #delaytime buffer[3] <= Memory[address][3];
        #delaytime buffer[4] <= Memory[address][4];
        #delaytime buffer[5] <= Memory[address][5];
        #delaytime buffer[6] <= Memory[address][6];
        #delaytime buffer[7] <= Memory[address][7];

    end
end

assign data = (read_enable & ~write_enable) ? buffer : 8'bzzzzzzzz;

endmodule