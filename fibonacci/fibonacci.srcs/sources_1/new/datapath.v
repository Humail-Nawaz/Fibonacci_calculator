`timescale 1ns / 1ps
//datatpth for fibonacci
module datapath(
                input clk,reset,wen,
                input [31:0] n,
                input [1:0] asel,bsel,wsel,
                input [2:0] opsel,
                output z,
                output [31:0] result);
reg [31:0] R0,R1,R2,R3;         //R0=A=0; R1=B=1; R2=J=1; R3=N=FIBONACCI NUMBER
wire [31:0] asel_out,bsel_out,alu_out;
reg [31:0] LE;

//defining registers
always @(posedge clk or posedge reset) begin
    if(reset) begin
        R0<=32'd0; //A=0
        R1<=32'd1; //B=1
        R2<=32'd0; //J=1
        R3<=n;     //N
       end 
    else if(LE[0] && wen) 
            R0<=alu_out; 
    else if(LE[1] && wen)
             R1<=alu_out; 
    else if(LE[2] && wen) 
            R2<=alu_out; 
    else if(LE[3] && wen) 
            R3<=alu_out; 
   else
     begin
        R0<=R0; //A=0
        R1<=R1; //B=1
        R2<=R2; //J=1
        R3<=R3; //N
      end
 end
 // decoder
 always@(wsel) begin
case(wsel)
2'b00: LE = 4'b0001;
2'b01: LE = 4'b0010;
2'b10: LE = 4'b0100;
2'b11: LE = 4'b1000;
endcase
end
 // asel mux
 assign asel_out=(asel==0)? R0 :    //a
                 (asel==1)? R1 :    //b
                 (asel==2)? R2 :    //j
                 (asel==3)? R3 :    //N
                 32'bx;
 // bsel mux
 assign bsel_out=(bsel==0)? R0 :    //a
                 (bsel==1)? R1 :    //b
                 (bsel==2)? R2 :    //j
                 (bsel==3)? R3 :    //N
                 32'bx;
 // ALU
 assign alu_out= (opsel==3'b000)?asel_out+bsel_out:   // addition        --opsel=0
                 (opsel==3'b001)?asel_out-bsel_out:   // subtraction     --opsel=1
                 (opsel==3'b010)?asel_out*bsel_out:   // multiplication  --opsel=2
                 (opsel==3'b100)?asel_out+64'd1:          // incrementation  --opsel=3
                 (opsel==3'b011)?~(asel_out&bsel_out):   // NAND         --opsel=4
                 //(opsel==3'b101)?asel_out+0:   // addition of asel_out and zero for output  opsel=5
                 32'bx;
// comparator
assign z=(asel_out==bsel_out);
//output 
assign result=R0;
endmodule