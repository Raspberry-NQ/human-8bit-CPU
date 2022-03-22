`timescale 1ms/100us
`include "ALU.v"
`include "PC.v"
`include "control.v"
`include "register-8.v"
`include "register-4.v"
`include "block8.v"
`include "block4.v"
`include "RAM.v"
`include "bcd2disp.v"
`include "BUSdelay.v"
`include "CTRLdelay.v"


module CPU(input clkin, /*output [7:0] OutPut, */output [7:0] LED,output HLTO);
wire [7:0] bus;
wire [3:0] MemAddr;
wire [7:0] Aout;
wire [7:0] Bout;
wire [7:0] Instout;
wire [3:0] Pcount;
wire [3:0] Addr_in;
wire [7:0] Dispout;
wire [7:0] aluOut;
wire HLT,AI,AO,BI,MI,RR,RW,II,IO,CI,CO,CE,ALUOPTION,ALUO,DI,FL;
wire AIO,AOO,BIO.MIO,RRO,RWO,IIO,IOO,CIO,COO,CEO,ALUOPTIONO,ALUO,DIO,FLO;
wire PCrst, flag;
wire clk;
wire [7:0] OutPut;

assign clk = (clkin & ~HLTO);
    wire [8:0] BUSTOA;
    BUSdelay DA(.I(bus),.O(BUSTOA));
    register8 A(.clk(clk), .data_in(BUSTOA),  .EI(AIO),.data_out(Aout));
    block8 triA(.data(Aout), .dataOut(bus), .enable(AOO));

    wire [8:0] BUSTOB;
    BUSdelay DB(.I(bus),.O(BUSTOB));
    register8 B(.clk(clk), .data_in(BUSTOB),.EI(BIO), .data_out(Bout) );

    wire [8:0] BUSTOINST;
    BUSdelay DINST(.I(bus),.O(BUSTOINST));
    register8 InstReg(.clk(clk), .data_in(BUSTOINST),  .EI(IIO),.data_out(Instout));
    block4 triInstReg(.data(Instout[3:0]), .dataOut(bus[3:0]), .enable(IOO));

    ALU alu(.A(Aout), .B(Bout), .op(ALUOPTIONO),.FLAGENABLE(FLO), .res({flag,aluOut}));
    block8 tri_alu(.data(aluOut), .enable(ALUOO), .dataOut(bus));


    PC pc(.clk(clk), .rst(1'b0), .enable(CEO), .jmp(CIO), .jmploc(bus[3:0]), .count(Pcount));
    block4 tripc(.data(Pcount), .dataOut(bus[3:0]), .enable(COO));


    register4 MemAdd(.clk(clk), .data_in(bus[3:0]),  .EI(MIO),.data_out(Addr_in));

    RAM ram(.clk(~clk), .address(Addr_in), .write_enable(RWO), .read_enable(RRO), .data(bus));


    control ic(.CLK(clk),.command(Instout[7:4]), .ctrl_wrd({HLT,AI,AO,BI,MI,RR,RW,II,IO,CI,CO,CE,ALUOPTION,ALUO,DI,FL}));
    CTRLdelay CHLT(.I(HLT),.O(HLTO));
    CTRLdelay CAI(.I(AI),.O(AIO));
    CTRLdelay CAO(.I(AO),.O(AOO));
    CTRLdelay CBI(.I(BI),.O(BIO));
    CTRLdelay CMI(.I(MI),.O(MIO));
    CTRLdelay CRR(.I(RR),.O(RRO));
    CTRLdelay CRW(.I(RW),.O(RWO));
    CTRLdelay CII_(.I(II),.O(IIO));
    CTRLdelay CIO_(.I(IO),.O(IOO));
    CTRLdelay CCI(.I(CI),.O(CIO));
    CTRLdelay CCO(.I(CO),.O(COO));
    CTRLdelay CALUOPTION(.I(ALUOPTION),.O(ALUOPTIONO));
    CTRLdelay CALUO(.I(ALUO),.O(ALUOO));
    CTRLdelay CDI(.I(DI),.O(DIO));
    CTRLdelay CFL(.I(FL),.O(FLO));


    register8 O(.clk(clk), .data_in(bus), .EI(DIO), .data_out(LED));


//bcd2sevenseg seg0(.bcd(OutPut[3:0]), .seg(LED1));
//bcd2sevenseg seg1(.bcd(OutPut[7:4]), .seg(LED2));

endmodule

