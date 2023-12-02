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
    input clock, moved, input [1:0] checkmate,
    output reg player_turn = 0, output reg end_game, output reg winner
//    output reg [2:0] led
);
    
    reg [31:0] count;
    reg [31:0] count_1m;
    reg [31:0] clk_1m;
    reg [1:0] reset_s = 0;
    reg [1:0] reset_l = 0;
    reg [31:0] move_count = 0;
    
//    wire [31:0] count_1s = 49_999_999;
    wire [31:0] count_1s = 100_000_000;
    wire clk_1s;
//    flexible_clock clk1s (.basys_clk(clock), .count_in(count_1s), .out_clk(clk_1s));    
    
//    reg [1:0] player = 0;
//    reg [1:0] end_game = 0;
    
    initial begin
        count = 0;
        count_1m = 0;
        clk_1m = 0;
        end_game = 0;
//        led[1] <= 0;
//        led[0] <= 0;
    end
    
    always @ (posedge moved) begin
        player_turn = ~player_turn;
    end
    
    always @ (posedge clock) begin
        if (moved) 
//        if (btnC)
        begin
            move_count = (move_count >= 5) ? move_count : move_count + 1;
        end
        
        if (moved == 0 && move_count >= 5) move_count = 0;
//        if (btnC == 0) move_count <= 0;
        
        if (move_count == 1)
        begin
            reset_s = 1;
            reset_l = 1;
//            player_turn = ~player_turn;
//            led[0] <= player_turn;
        end

//        count <= (count == count_1s) ? 0 : count + 1;
        
        if (count == count_1s || reset_s)
        begin
//            led[0] <= (led[0]) ? 0 : 1;
            count = 0;
            reset_s = 0;
        end
        else count = count + 1;
        
//        count_1m <= (count == 0) ? count_1m + 1 : count_1m;
        
        if (count == 0)
        begin
            count_1m = count_1m + 1;
        end
        
        if (count_1m > 60)
        begin
//            led[0] <= (led[0]) ? 0 : 1;
            end_game = 1;
            winner = ~player_turn;
        end
        
        if (checkmate[0])
        begin
            end_game = 1;
            winner = 1;
        end

        if (checkmate[1])
        begin
            end_game = 1;
            winner = 0;
        end
        
        if (reset_l)
        begin
            reset_l = 0;
            count_1m = 0;
        end

        
    end
    
endmodule