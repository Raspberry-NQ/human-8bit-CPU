`timescale 1ns/1ps
`include "ALU.v"
`include "PC.v"
`include "control.v"
`include "register-8.v"
`include "register-4.v"
`include "block8.v"
`include "block4.v"
`include "RAM.v"
`include "bcd2disp.v"


module CPU(input clkin, /*output [7:0] OutPut, */output [7:0] LED,output HLT);
wire [7:0] bus;
wire [3:0] MemAddr;
wire [7:0] Aout;
wire [7:0] Bout;
wire [7:0] Instout;
wire [3:0] Pcount;
wire [3:0] Addr_in;
wire [7:0] Dispout;
wire [7:0] aluOut;
wire AI,AO,BI,MI,RR,RW,II,IO,CI,CO,CE,ALUOPTION,ALUO,DI,FL;
wire PCrst, flag;
wire clk;
wire [7:0] OutPut;

assign clk = (clkin & ~HLT);


    register8 A(.clk(clk), .data_in(bus),  .EI(AI),.data_out(Aout));
    block8 triA(.data(Aout), .dataOut(bus), .enable(AO));

    register8 B(.clk(clk), .data_in(bus),.EI(BI), .data_out(Bout) );

    register8 InstReg(.clk(clk), .data_in(bus),  .EI(II),.data_out(Instout));
    block4 triInstReg(.data(Instout[3:0]), .dataOut(bus[3:0]), .enable(IO));

    ALU alu(.A(Aout), .B(Bout), .op(ALUOPTION),.FLAGENABLE(FL), .res({flag,aluOut}));
    block8 tri_alu(.data(aluOut), .enable(ALUO), .dataOut(bus));


    PC pc(.clk(clk), .rst(1'b0), .enable(CE), .jmp(CI), .jmploc(bus[3:0]), .count(Pcount));
    block4 tripc(.data(Pcount), .dataOut(bus[3:0]), .enable(CO));


    register4 MemAdd(.clk(clk), .data_in(bus[3:0]),  .EI(MI),.data_out(Addr_in));

    RAM ram(.clk(~clk), .address(Addr_in), .write_enable(RW), .read_enable(RR), .data(bus));


    control ic(.CLK(clk),.command(Instout[7:4]), .ctrl_wrd({HLT,AI,AO,BI,MI,RR,RW,II,IO,CI,CO,CE,ALUOPTION,ALUO,DI,FL}));


    register8 O(.clk(clk), .data_in(bus), .EI(DI), .data_out(LED));


//bcd2sevenseg seg0(.bcd(OutPut[3:0]), .seg(LED1));
//bcd2sevenseg seg1(.bcd(OutPut[7:4]), .seg(LED2));

endmodule

