`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2023 02:16:15
// Design Name: 
// Module Name: board_art_sim
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


module board_art_sim();
    reg clock = 0, player = 0, cur_player;
    wire [7:2] JA, JB;
    reg [2:0]old_x=0, old_y=0, new_x=0, new_y=0;
    reg [3:0] state;
    reg [12:0] pix_index;
    reg [63:0] avail_array;
    wire [15:2] oled_data;
    wire [2:0] cursor_x;
    wire [2:0] cursor_y;
    wire PS2Clk, PS2Data;
    reg moved = 0;
    
    board_art board_art_unit(
        clock, 1, cur_player,
        JA, JB,    
        old_x, old_y, new_x, new_y, 
        state, 
        pix_index,
        avail_array,
        oled_data,
        cursor_x, cursor_y,
        PS2Clk, PS2Data,
        2'b0, moved
        //output reg [15:0] led
    );
    
    initial begin
        #50 cur_player = 0;
        #50 state=1; old_x=6; old_y=2; new_x=4; new_y=2; moved = 1;
        
        #50 cur_player = 1;
        #50 moved = 0;
        #100 state=9; old_x=1; old_y=2; new_x=3; new_y=2; moved = 1;
        
        #50 cur_player = 0;
        #50 moved = 0;
        #100 state=1; old_x=6; old_y=4; new_x=5; new_y=4; moved = 1;
        
        #50 cur_player = 1;
        #50 moved = 1;
    end
    
    always begin
        #5 clock = ~ clock;
    end


endmodule
