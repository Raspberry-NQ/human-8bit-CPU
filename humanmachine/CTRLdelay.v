`timescale 1ms/100ns
module CTRLdelay(input I,output O);
	parameter delaytime=5;
	assign #delaytime O=I;
endmodule