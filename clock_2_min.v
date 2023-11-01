`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2023 12:10:35
// Design Name: 
// Module Name: clock_2_min
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


module clock_2_min(input clock, output reg clk_2m);

    reg [31:0] count = 0;
    reg [31:0] count_6 = 0;
    wire [31:0] count_2d6m = 1_000_000_000;
    
    always @ (posedge clock) begin
        count <= (count == count_2d6m) ? 0 : count + 1;
        
        if (count == count_2d6m)
        begin
            count_6 <= (count_6 == 6) ? 0 : count_6 + 1;
        end
        
        clk_2m <= (count_6 == 6) ? ~clk_2m : clk_2m;
    end
    
endmodule
