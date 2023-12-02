`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.11.2023 14:20:59
// Design Name: 
// Module Name: move_sim
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


module move_sim();
    reg CLOCK;
    reg player1;
    reg turn = 1;
    reg [2:0] coordX1, coordY1;
    reg [2:0] coordX2, coordY2;
    wire [2:0] old_posX, old_posY, new_posX, new_posY;
    wire [2:0] old_posX2, old_posY2, new_posX2, new_posY2;
    wire moved;
    wire [63:0] avail_moves_out;
    wire [3:0] piece_selected;
    
    chess_engine unit1(
        CLOCK,
        0,       // 0: white, 1: black
        coordX, coordY,     // range from 0 to 7
        old_posX, old_posY, new_posX, new_posY,   // to update chess board in top module   
        moved,         // notify that movement is complete and turn should end
        avail_moves_out,
        piece_selected
    );
    
    chess_engine unit2(
        CLOCK,
        1,       // 0: white, 1: black
        coordX, coordY,     // range from 0 to 7
        old_posX, old_posY, new_posX, new_posY,   // to update chess board in top module   
        moved,         // notify that movement is complete and turn should end
        avail_moves_out,
        piece_selected
    );    

endmodule
