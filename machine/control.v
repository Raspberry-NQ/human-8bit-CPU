`timescale 1ms/1ns

module control(	input [3:0] command,
				input CLK,
				output reg [15:0] ctrl_wrd
				);
	
	reg [2:0] count ;
	reg reset_in;
	/*
	0000 
	0001 LDA
	0010 LDB
	0011 PLUSTOA
	0100 PLUSTOB
	0101 SUBTOA
	0110 SUBTOB
	0111 ATORAM
	1000 JUMP
	1001 ATODIS
	1010 POWEROFF
	*/
	
	parameter HLT=	16'b1000000000000000;
	parameter AI=	16'b0100000000000000;
	parameter AO=	16'b0010000000000000;
	parameter BI=	16'b0001000000000000;
	parameter MI= 	16'b0000100000000000;
	parameter RR=	16'b0000010000000000;
	parameter RW=	16'b0000001000000000;
	parameter II=	16'b0000000100000000;
	parameter IO=   16'b0000000010000000;
	parameter CI=   16'b0000000001000000;
	parameter CO=   16'b0000000000100000;
	parameter CE=   16'b0000000000010000;
	parameter ALUOPTION=	16'b0000000000001000;//OPTION->1->SUBMIT;->0->PLUS
	parameter ALUO=	16'b0000000000000100;
	parameter DI=	16'b0000000000000010;
	parameter FL=	16'b0000000000000001;
	

	
initial begin
    count <= 3'b111;
    reset_in <= 1'b0;
end
always @ (posedge CLK)
    begin
        count = reset_in ? 3'b000 : count+1;
        reset_in = 1'b0;
        case(count)
            3'b000: ctrl_wrd = CO|MI;
            3'b001: ctrl_wrd = RR|II|CE;
            3'b010: begin
                    case(command)
                    4'b0001: ctrl_wrd = IO|MI; // LDA
                    4'b0010: ctrl_wrd = IO|MI; //LDB
                    4'b0011: ctrl_wrd = ALUO|AI;  //PLUSTOA
                    4'b0100: ctrl_wrd = ALUO|BI; // PLUSTOB
                    4'b0101: ctrl_wrd = ALUOPTION|ALUO|AI; // SUBTOA
                    4'b0110: ctrl_wrd = ALUOPTION|ALUO|BI; // SUBTOB
                    4'b0111: ctrl_wrd = IO|MI;//ATORAM
                    4'b1000: ctrl_wrd = IO|CI;//JUMP
                    4'b1001: ctrl_wrd = AO|DI;//ATODIS
                    4'b1010: ctrl_wrd = HLT;//POWEROFF
                    default: ctrl_wrd = 16'b0000000000000000;
                    endcase 
                    end      
            3'b011: begin
                    case(command)
                    4'b0001: ctrl_wrd = RR|AI; // LDA
                    4'b0010: ctrl_wrd = RR|BI; //LDB
                    4'b0011: ctrl_wrd = 16'b0000000000000000;  //PLUSTOA
                    4'b0100: ctrl_wrd = 16'b0000000000000000; // PLUSTOB
                    4'b0101: ctrl_wrd = 16'b0000000000000000; // SUBTOA
                    4'b0110: ctrl_wrd = 16'b0000000000000000; // SUBTOB
                    4'b0111: ctrl_wrd = AO|RW;//ATORAM
                    4'b1000: ctrl_wrd = 16'b0000000000000000;//JUMP
                    4'b1001: ctrl_wrd = 16'b0000000000000000;//ATODIS
                    4'b1010: ctrl_wrd = 16'b0000000000000000;//POWEROFF
                    default: ctrl_wrd = 16'b0000000000000000;
                    endcase
                    reset_in = 1'b1; // Have some doubt here..... Maybe this part can go wrong .....             
                    end
                    /*
            3'b100: begin
                    case(command)
                    4'b0001: ctrl_wrd = 15'b000000000000000; // LDA done
                    4'b0010: ctrl_wrd = 15'b000000101000000; //ADD
                    4'b0011: ctrl_wrd = 15'b000000101100000; //SUBT
                    4'b1110: ctrl_wrd = 15'b000000000000000; // OUT
                    4'b0100: ctrl_wrd = 15'b000000000000000; // JMP
                    4'b1111: ctrl_wrd = 15'b000000000000000; // HLT
                    default: ctrl_wrd = 15'b000000000000000;
                    endcase 
                    
                    end    
                    */              
            default: ctrl_wrd = 16'b0000000000000000;
        endcase                          
    end



endmodule