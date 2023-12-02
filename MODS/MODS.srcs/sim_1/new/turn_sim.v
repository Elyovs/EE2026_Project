`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.11.2023 17:28:57
// Design Name: 
// Module Name: turn_sim
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


module turn_sim();
    
    reg clock = 0, moved = 0;
    wire player_turn, end_game, winner;
    
    player_turn_1_min player_turn_1_min_unit(
        clock, moved, 2'b0,
        player_turn, end_game, winner
    );
    
    initial begin
        #50 moved = 1; 
        #50 moved = 0;
        #200 moved = 1; 
//        #50 moved = 0;
//        #200 moved = 1; 
//        #50 moved = 0;
    end
    
    always begin
        #5 clock = ~clock;
    end

endmodule
