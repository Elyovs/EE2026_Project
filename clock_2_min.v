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


module player_turn_1_min(
    input clock, moved,
    output reg player_turn, output reg end_game, output reg winner
//    output reg [2:0] led, 
);
    
    reg [31:0] count;
    reg [31:0] count_6;
    reg [1:0] clk_1m;
    wire [31:0] count_2d6m = 49_999_999;
    reg [1:0] reset_s = 0;
    reg [1:0] reset_l = 0;
    reg [31:0] move_count = 0;
    
    
    
//    reg [1:0] player = 0;
//    reg [1:0] end_game = 0;
    
    initial begin
        count <= 0;
        count_6 <= 0;
        clk_1m <= 0;
    end
    
    always @ (posedge clock) begin
        if (moved) 
//        if (btnC)
        begin
            move_count <= (move_count > 5) ? move_count : move_count + 1;
        end
        
        if (moved == 0) move_count <= 0;
        
        if (move_count == 1)
        begin
            reset_s <= 1;
            reset_l <= 1;
            player_turn <= ~player_turn;
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
            count_6 <= (count_6 == 120) ? 0 : count_6 + 1;
            clk_1m <= (count_6 == 120) ? ~clk_1m : clk_1m;
        end
        
        if (count_6 == 120 && end_game == 0)
        begin
            end_game <= 1;
            winner <= clk_1m;
        end
        
//        if (clk_2m)
//        begin
//            end_game <= 1;
//            winner <= 
//        end 
        
//        led[1] <= clk_2m;   //led toggle every 1 minute
//                            //on - off - on -> 2 min
//        led[0] <= ~player;
//        led[1] <= player;
//        led[2] <= end_game; //end game when 2 min passed
        
    end
    
endmodule
