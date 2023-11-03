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


module player_turn_2_min(input clock, btnC, output reg [1:0] led);
    
    reg [31:0] count = 0;
    reg [31:0] count_6 = 0;
    reg clk_2m = 0;
    wire [31:0] count_2d6m = 1_000_000_000;
    reg reset_s = 0;
    reg reset_l = 0;
    
    always @ (posedge clock) begin
        if (btnC) 
        begin
            reset_s <= 1;
            reset_l <= 1;
        end
        
        if (count == count_2d6m || reset_s)
        begin
            count <= 0;
            reset_s <= 0;
        end
        else count <= count + 1;
        
        if (reset_l)
        begin
            reset_l <= 0;
            count_6 <= 0;
        end
        
        if (count == count_2d6m)
        begin
            count_6 <= (count_6 == 6) ? 0 : count_6 + 1;
        end
        
        clk_2m <= (count_6 == 6) ? ~clk_2m : clk_2m;
        
        led[0] <= clk_2m;   //led toggle every 1 minute
                            //on - off - on -> 2 min
        
    end
    
endmodule
