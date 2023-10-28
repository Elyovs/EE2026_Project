`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2023 16:02:40
// Design Name: 
// Module Name: chess_engine
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


module chess_engine(
    input CLOCK,
    input player,       // 0: white, 1: black
    input [2:0] coordX, coordY,     // range from 0 to 7
    output [2:0] old_pos, new_pos,   // to update chess board in top module   
    output reg moved,         // notify that movement is complete and turn should end
    output reg [63:0] avail_moves_out
    );
    
    // Constant parameters
    parameter EMPTY = 3'b000;
    parameter PAWN = 3'b001;
    parameter BISHOP = 3'b010;
    parameter KNIGHT = 3'b011;
    parameter ROOK = 3'b100;
    parameter QUEEN = 3'b101;
    parameter KING = 3'b110;
    
    parameter WHITE = 1'b0;
    parameter BLACK = 1'b1;
    
    // eg. board_state[0][0][3] = WHITE;
    // eg. board_state[0][0][2:0] = PAWN;
    
    // Variable registers and wires
    reg [3:0] board [7:0] [7:0]; // 8x8 board with 3 bit value in each place o represent pieces
    reg avail_moves [7:0] [7:0];
    integer i, j;  // variables for for loop
    
    
    // Initiate the chess board
    initial begin
        for (i = 0; i <= 7; i = i + 1) begin
            board[0][i][3] = BLACK;
            board[1][i][3] = BLACK;
            board[1][i][2:0] = PAWN;
            board[6][i][3] = WHITE;
            board[6][i][2:0] = PAWN;
            board[7][i][3] = WHITE;
        end
        // Black
        board[0][0][2:0] = ROOK;
        board[0][1][2:0] = KNIGHT;
        board[0][2][2:0] = BISHOP;
        board[0][3][2:0] = QUEEN;
        board[0][4][2:0] = KING;
        board[0][5][2:0] = BISHOP;
        board[0][6][2:0] = KNIGHT;
        board[0][7][2:0] = ROOK;
        // White
        board[7][0][2:0] = ROOK;
        board[7][1][2:0] = KNIGHT;
        board[7][2][2:0] = BISHOP;
        board[7][3][2:0] = QUEEN;
        board[7][4][2:0] = KING;
        board[7][5][2:0] = BISHOP;
        board[7][6][2:0] = KNIGHT;
        board[7][7][2:0] = ROOK;
        // Available moves
        for (i = 0; i <= 7; i = i + 1) begin
            for (j = 0; j <= 7; j = j + 1) begin
                avail_moves[i][j] = 0;
            end
        end
    end
    
    // Main always block
    always @ (posedge CLOCK) begin
        // Selected your piece
        if (board[coordX][coordY][2:0] != EMPTY && board[coordX][coordY][3] == player) begin
            // Generate possible moves
            if (board[coordX][coordY][2:0] == PAWN) begin
            
            end
            if (board[coordX][coordY][2:0] == BISHOP) begin
            
            end
            if (board[coordX][coordY][2:0] == KNIGHT) begin
            
            end
            if (board[coordX][coordY][2:0] == ROOK) begin
                for (j = coordX; j < 8; j = j + 1) begin
                
                end
            end
            if (board[coordX][coordY][2:0] == QUEEN) begin
            
            end
            if (board[coordX][coordY][2:0] == KING) begin
            
            end

        end 
        else if (avail_moves[coordX][coordY] == 1) begin
            // moved
        end
    end
    
    
    
endmodule
