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


module player_turn_2_min(input clock, btnC, output reg [2:0] led);
    
    reg [31:0] count;
    reg [31:0] count_6;
    reg [1:0] clk_2m;
    wire [31:0] count_2d6m = 49_999_999;
    reg [1:0] reset_s = 0;
    reg [1:0] reset_l = 0;
    
    reg [1:0] player = 0;
    reg [1:0] end_game = 0;
    
    initial begin
        count <= 0;
        count_6 <= 0;
        clk_2m <= 0;
    end
    
    always @ (posedge clock) begin
        if (btnC) 
        begin
            reset_s <= 1;
            reset_l <= 1;
            player <= ~player;
        end
        
        count <= (count == count_2d6m) ? 0 : count + 1;
        
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
            count_6 <= (count_6 == 240) ? 0 : count_6 + 1;
            clk_2m <= (count_6 == 240) ? ~clk_2m : clk_2m;
        end
        
        if (clk_2m)
        begin
            end_game <= 1;
        end 
        
//        led[1] <= clk_2m;   //led toggle every 1 minute
//                            //on - off - on -> 2 min
        led[0] <= ~player;
        led[1] <= player;
        led[2] <= end_game; //end game when 2 min passed
        
    end
    
endmodule
