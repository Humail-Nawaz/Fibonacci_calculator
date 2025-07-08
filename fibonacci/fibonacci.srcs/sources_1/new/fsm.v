// SPDX-License-Identifier: Apache-2.0
// Copyright 2025 Humail Nawaz

`timescale 1ns / 1ps
module fsm(
            input clk,reset,z,
            output [1:0] asel,bsel,wsel,
            output [2:0] opsel,
            output wen);
reg [2:0] state, nstate;
parameter loop_add=3'b000;
parameter loop_sub=3'b001;
parameter loop_j=3'b010;
parameter compare=3'b011;
parameter done=3'b100;
// present state sequential logic
always @(posedge clk or posedge reset) begin
    if(reset)
       state<=loop_add;
    else
       state<=nstate;
end
//next state combinational logic
always@(*) begin
  case(state)
  loop_add: nstate<=loop_sub;
  loop_sub: nstate<=loop_j;
  loop_j  : nstate<=compare;
  compare : if(z==1) nstate <= done;  else nstate <= loop_add; 
  done: nstate<=done;
  endcase
end 
//output combinational logic                              {asel, bsel, opsel, wen, wsel}
assign {asel,bsel,opsel,wen,wsel} =  (state == loop_add)?{2'b00,2'b01,3'b000,1'b1,2'b01}:
                                     (state == loop_sub)?{2'b01,2'b00,3'b001,1'b1,2'b00}:
                                     (state == loop_j)?{2'b10,2'b10,3'b100,1'b1,2'b10}:
                                     (state == compare)?{2'b10,2'b11,3'bx,1'b0,2'bx}:
                                     (state == done)?{2'b10,2'b11,3'bx,1'b0,2'bx}:
                                      {2'b10,2'b11,3'bx,1'b0,2'bx};
endmodule
