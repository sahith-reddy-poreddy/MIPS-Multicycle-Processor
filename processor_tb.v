`timescale 1ns / 1ps

module processor_tb();
reg clk, reset;

initial begin 
 clk=1'd0;
 reset=1'd0;
 end
 
 always@(clk) begin
 #50 clk<=~clk; 
 end
processor u_processor(.clk(clk), .reset(reset));
endmodule
