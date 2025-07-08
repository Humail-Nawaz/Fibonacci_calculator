// SPDX-License-Identifier: Apache-2.0
// Copyright 2025 Humail Nawaz

`timescale 1ns / 1ps
module top_module(
    input clk,
    input [31:0] n,
    input reset,
    output[31:0] result
    );
wire[1:0] asel,bsel,wsel;
wire[2:0] opsel;
wire wen;
datapath dp_inst(
    .clk(clk),        //clk
    .n(n),            //index n
    .reset(reset),    //reset
    .z(z),            //z
    .asel(asel),      //asel
    .bsel(bsel),      //bsel  
    .opsel(opsel),    //opsel
    .wsel(wsel),      //wsel
    .wen(wen),        //wen
    .result(result)   //result
   );
fsm fsm_inst(
    .clk(clk),        //clk
    .reset(reset),    //reset
    .z(z),            //z
    .asel(asel),      //asel
    .bsel(bsel),      //bsel  
    .opsel(opsel),    //opsel
    .wsel(wsel),      //wsel
    .wen(wen)         //wen
   );
endmodule
