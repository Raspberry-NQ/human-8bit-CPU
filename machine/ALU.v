`timescale 1ns/1ps
module ALU(input op, input [7:0] A, input [7:0] B,input FLAGENABLE ,output [8:0] res);//op->1->submit op->0->plus
wire flag;
wire [8:0] outdata;
assign outdata[8:0] = op ? (A[7:0] - B[7:0]) : (A[7:0] + B[7:0]);
assign res[7:0]=outdata[7:0];
assign res[8]=FLAGENABLE? outdata[8]: 1'b0;
endmodule