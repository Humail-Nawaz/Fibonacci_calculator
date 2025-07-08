`timescale 1ns / 1ps
module test_bench();
reg clk, reset; reg [31:0]n;
wire [31:0] result;
top_module t1(
        .clk(clk),
        .reset(reset),
        .result(result),
        .n(n));
  initial begin
    clk=0;
    forever #10 clk = ~clk;
    end
    initial begin
    $display("Starting calculation ");
    reset=1; 
    n=32'd6;      
    #30; reset=0;
    //#500;
    end
endmodule
