`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2023 21:55:39
// Design Name: 
// Module Name: debouncer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module debouncer(input in_signal, clock, output out_signal);
    
    wire count = 12_499_999;
    wire clk_4hz;
    flexible_clock clk4hz(.basys_clk(clock), .count_in(count), .out_clk(clk_4hz));
    
    wire Q1;
    wire Q2;
    
    DFF DFF1 (.clock(clk_4hz), .D(in_signal), .Q(Q1));
    DFF DFF2 (.clock(clk_4hz), .D(Q1), .Q(Q2));
    
    assign out_signal = Q1 & (~Q2);
    
endmodule
