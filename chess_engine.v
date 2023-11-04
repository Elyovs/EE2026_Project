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

// new=1 -> process chess engine -> moved=1 -> update outside -> new=1 -> restart process

module chess_engine(
    input CLOCK,
    input player,       // 0: white, 1: black
//    input new,          // Should change once update finish and new player selected ? dk need anot
    input [2:0] coordX, coordY,     // range from 0 to 7
    output reg [2:0] old_posX, old_posY, new_posX, new_posY,   // to update chess board in top module   
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
    
    // eg. board[0][0][3] = WHITE;
    // eg. board[0][0][2:0] = PAWN;
    
    // Variable registers and wires
    reg [3:0] board [0:7] [0:7]; // 8x8 board with 3 bit value in each place o represent pieces
    reg avail_moves [0:7] [0:7]; // 8x8 board for available moves, to be converted into single array
    integer i, j, k, curX, curY;  // variables for for loop
    reg [3:0] h_delta, v_delta; // horizontal and vertical differences
    reg [7:0] blocked; // [3:0] for ROOK, [7:4] for bishop, QUEEN use all
    reg [3:0] piece_selected = 4'b0000;
    
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
        // Set remaining squares
        for (i = 2; i <= 5; i = i + 1) begin
            for (j = 0; j <= 7; j = j + 1) begin
                board[i][j] = 0;
            end
        end
        // Available moves
        for (i = 0; i <= 7; i = i + 1) begin
            for (j = 0; j <= 7; j = j + 1) begin
                avail_moves[i][j] = 0;
            end
        end
    end
    
    // Convert 2d array avail_moves to 1d avail_moves_out
    always @ (posedge CLOCK) begin
        for (i = 0; i <= 7; i = i + 1) begin    // row
            for (j = 0; j <= 7; j = j + 1) begin    // col
                avail_moves_out[8 * i + j] = avail_moves[i][j];
            end
        end
    end
    
    // Main always block
    always @ (posedge CLOCK) begin
        // Reset blocked for new piece
        blocked = 8'b0;
        // Check if new player turn ?
        // Selected your piece
        if (board[coordX][coordY][2:0] != EMPTY && board[coordX][coordY][3] == player) begin
            // Keep track of selected piece and coordinates
            piece_selected = board[coordX][coordY];
            old_posX = coordX;
            old_posY = coordY;
            // Reset available moves matrix
            for (i = 0; i <= 7; i = i + 1) begin
                for (j = 0; j <= 7; j = j + 1) begin
                    avail_moves[i][j] = 0;
                end
            end
            // Generate possible moves
            if (board[coordX][coordY][2:0] == PAWN) begin   // done
                if (board[coordX][coordY][3] == WHITE) begin    // White pawn
                    if (coordX == 6) begin  // Can move 2 steps if no block
                        avail_moves[coordX-2][coordY] = (board[coordX-1][coordY][2:0] == EMPTY) ? 1 : 0;
                    end
                    if (coordX > 0) begin   // Normal steps
                        if (board[coordX-1][coordY][2:0] == EMPTY) begin
                            avail_moves[coordX-1][coordY] = 1;
                        end
                        if (coordY > 0) begin   // Left capture
                            if (board[coordX-1][coordY-1][3] == BLACK && board[coordX-1][coordY-1][2:0] != EMPTY) begin
                                avail_moves[coordX-1][coordY-1] = 1;
                            end
                        end
                        if (coordY < 7) begin   // Right capture
                            if (board[coordX-1][coordY+1][3] == BLACK && board[coordX-1][coordY+1][2:0] != EMPTY) begin
                                avail_moves[coordX-1][coordY+1] = 1;       
                            end
                        end
                    end
                end
                else begin      // Black pawn
                    if (coordX == 1) begin  // Can move 2 steps if no block
                        avail_moves[coordX+2][coordY] = (board[coordX+1][coordY][2:0] == EMPTY) ? 1 : 0;
                    end
                    if (coordX < 7) begin   // Normal steps
                        if (board[coordX+1][coordY][2:0] == EMPTY) begin
                            avail_moves[coordX+1][coordY] = 1;
                        end
                        if (coordY > 0) begin   // Left capture
                            if (board[coordX+1][coordY-1][3] == WHITE && board[coordX+1][coordY-1][2:0] != EMPTY) begin
                                avail_moves[coordX+1][coordY-1] = 1;
                            end
                        end
                        if (coordY < 7) begin   // Right capture
                            if (board[coordX+1][coordY+1][3] == WHITE && board[coordX+1][coordY+1][2:0] != EMPTY) begin
                            avail_moves[coordX+1][coordY+1] = 1;
                            end
                        end
                    end
                end
            end
            if (board[coordX][coordY][2:0] == BISHOP || board[coordX][coordY][2:0] == QUEEN) begin // done
                for (i = 1; i <= 7; i = i + 1) begin
                    // Left Up
                    curX = coordX - i;
                    curY = coordY - i;
                    if (curX >= 0 && curY >= 0) begin
                        if (blocked[4] == 0) begin // previous path not blocked yet
                            if (board[curX][curY][2:0] == EMPTY) begin // ntg at target location
                                avail_moves[curX][curY] = 1;
                            end
                            else begin // block by a piece
                                blocked[4] = 1;
                                if (board[curX][curY][3] != player) begin // if is opponent piece, still viable move
                                    avail_moves[curX][curY] = 1;
                                end
                            end
                        end
                    end
                    // Right Up
                    curX = coordX - i;
                    curY = coordY + i;
                    if (curX >= 0 && curY <= 7) begin
                        if (blocked[5] == 0) begin // previous path not blocked yet
                            if (board[curX][curY][2:0] == EMPTY) begin // ntg at target location
                                avail_moves[curX][curY] = 1;
                            end
                            else begin // block by a piece
                                blocked[5] = 1;
                                if (board[curX][curY][3] != player) begin // if is opponent piece, still viable move
                                    avail_moves[curX][curY] = 1;
                                end
                            end
                        end
                    end
                    // Left Down
                    curX = coordX + i;
                    curY = coordY - i;
                    if (curX <= 7 && curY >= 0) begin
                        if (blocked[6] == 0) begin // previous path not blocked yet
                            if (board[curX][curY][2:0] == EMPTY) begin // ntg at target location
                                avail_moves[curX][curY] = 1;
                            end
                            else begin // block by a piece
                                blocked[6] = 1;
                                if (board[curX][curY][3] != player) begin // if is opponent piece, still viable move
                                    avail_moves[curX][curY] = 1;
                                end
                            end
                        end
                    end
                    // Right Down
                    curX = coordX + i;
                    curY = coordY + i;
                    if (curX <= 7 && curY <= 7) begin
                        if (blocked[7] == 0) begin // previous path not blocked yet
                            if (board[curX][curY][2:0] == EMPTY) begin // ntg at target location
                                avail_moves[curX][curY] = 1;
                            end
                            else begin // block by a piece
                                blocked[7] = 1;
                                if (board[curX][curY][3] != player) begin // if is opponent piece, still viable move
                                    avail_moves[curX][curY] = 1;
                                end
                            end
                        end
                    end
                end
            end
            if (board[coordX][coordY][2:0] == KNIGHT) begin // need check whether blocked
                if (coordX-2 >= 0 && coordY-1 >= 0) begin 
                    if (board[coordX-2][coordY-1][2:0] == EMPTY || board[coordX-2][coordY-1][3] != player) begin
                        avail_moves[coordX-2][coordY-1] = 1; 
                    end
                end
                if (coordX-2 >= 0 && coordY+1 <= 7) begin 
                    if (board[coordX-2][coordY+1][2:0] == EMPTY || board[coordX-2][coordY+1][3] != player) begin
                        avail_moves[coordX-2][coordY+1] = 1; 
                    end
                end
                if (coordX-1 >= 0 && coordY-2 >= 0) begin 
                    if (board[coordX-1][coordY-2][2:0] == EMPTY || board[coordX-1][coordY-2][3] != player) begin
                        avail_moves[coordX-1][coordY-2] = 1; 
                    end
                end
                if (coordX-1 >= 0 && coordY+2 <= 7) begin 
                    if (board[coordX-1][coordY+2][2:0] == EMPTY || board[coordX-1][coordY+2][3] != player) begin
                        avail_moves[coordX-1][coordY+2] = 1; 
                    end
                end
                if (coordX+1 <= 7 && coordY-2 >= 0) begin 
                    if (board[coordX+1][coordY-2][2:0] == EMPTY || board[coordX+1][coordY-2][3] != player) begin
                        avail_moves[coordX+1][coordY-2] = 1; 
                    end
                end
                if (coordX+1 <= 7 && coordY+2 <= 7) begin
                    if (board[coordX+1][coordY+2][2:0] == EMPTY || board[coordX+1][coordY+2][3] != player) begin
                        avail_moves[coordX+1][coordY+2] = 1; 
                    end 
                end
                if (coordX+2 <= 7 && coordY-1 >= 0) begin 
                    if (board[coordX+2][coordY-1][2:0] == EMPTY || board[coordX+2][coordY-1][3] != player) begin
                        avail_moves[coordX+2][coordY-1] = 1; 
                    end
                end
                if (coordX+2 <= 7 && coordY+1 <= 7) begin 
                    if (board[coordX+2][coordY+1][2:0] == EMPTY || board[coordX+2][coordY+1][3] != player) begin
                        avail_moves[coordX+2][coordY+1] = 1; 
                    end
                end
            end 
            
            if (board[coordX][coordY][2:0] == ROOK || board[coordX][coordY][2:0] == QUEEN) begin // done
                // New
                for (i = 1; i <= 7; i = i + 1) begin
                    for (j = 1; j <= 7; j = j + 1) begin
                        // Up
                        curX = coordX - i;
                        if (curX >= 0) begin
                            if (blocked[0] == 0) begin // previous path not blocked yet
                                if (board[curX][coordY][2:0] == EMPTY) begin // ntg at target location
                                    avail_moves[curX][coordY] = 1;
                                end 
                                else begin // block by a piece
                                    blocked[0] = 1;
                                    if (board[curX][coordY][3] != player) begin // if is opponent piece, still viable move
                                        avail_moves[curX][coordY] = 1;
                                    end
                                end
                            end
                        end
                        // Down
                        curX = coordX + i;
                        if (curX <= 7) begin
                            if (blocked[1] == 0) begin // previous path not blocked yet
                                if (board[curX][coordY][2:0] == EMPTY) begin // ntg at target location
                                    avail_moves[curX][coordY] = 1;
                                end 
                                else begin // block by a piece
                                    blocked[1] = 1;
                                    if (board[curX][coordY][3] != player) begin // if is opponent piece, still viable move
                                        avail_moves[curX][coordY] = 1;
                                    end
                                end
                            end
                        end
                        // Left
                        curY = coordY - i;
                        if (curY >= 0) begin  
                            if (blocked[2] == 0) begin // previous path not blocked yet
                                if (board[coordX][curY][2:0] == EMPTY) begin // ntg at target location
                                    avail_moves[coordX][curY] = 1;
                                end 
                                else begin // block by a piece
                                    blocked[2] = 1;
                                    if (board[coordX][curY][3] != player) begin // if is opponent piece, still viable move
                                        avail_moves[coordX][curY] = 1;
                                    end
                                end
                            end
                        end
                        // Right
                        curY = coordY + i;
                        if (curY <= 7) begin  
                            if (blocked[3] == 0) begin // previous path not blocked yet
                                if (board[coordX][curY][2:0] == EMPTY) begin // ntg at target location
                                    avail_moves[coordX][curY] = 1;
                                end 
                                else begin // block by a piece
                                    blocked[3] = 1;
                                    if (board[coordX][curY][3] != player) begin // if is opponent piece, still viable move
                                        avail_moves[coordX][curY] = 1;
                                    end
                                end
                            end
                        end
                    end
                end
            end
//            if (board[coordX][coordY][2:0] == QUEEN) begin
                
//            end
            if (board[coordX][coordY][2:0] == KING) begin
            
            end

        end 
        // Selected somewhere to move to
        else if (avail_moves[coordX][coordY] == 1) begin
            // moved
            // Update board state & output relevant
//            output [2:0] old_posX, old_posY, new_posX, new_posY,   // to update chess board in top module   
//                output reg moved,
            if (piece_selected[2:0] == PAWN) begin  // Check promotion
                if (player == WHITE) begin
                    piece_selected[2:0] = (coordX == 0) ? QUEEN : piece_selected[2:0];
                end
                else begin  // BLACK
                    piece_selected[2:0] = (coordX == 7) ? QUEEN : piece_selected[2:0];
                end
            end
            board[coordX][coordY] = piece_selected;
            board[old_posX][old_posY][2:0] = EMPTY;
            new_posX = coordX;
            new_posY = coordY;
            moved = 1;
            // Reset available moves matrix - not sure if required
            for (i = 0; i <= 7; i = i + 1) begin
                for (j = 0; j <= 7; j = j + 1) begin
                    avail_moves[i][j] = 0;
                end
            end
        end
    end
    
    
    
endmodule
