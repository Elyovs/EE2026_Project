`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
 
//// Create Date: 27.10.2023 11:43:42
//// Design Name: 
//// Module Name: pieces_art
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
 
//// Dependencies: 
 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
 
//////////////////////////////////////////////////////////////////////////////////



module board_art (
    input clock, old_x, old_y, new_x, new_y, colour, //0 for white, 1 for black
    input [2:0] state, input [12:0] pix_index,
    input [63:0] in_avail_array,
    output reg [15:0] oled_data  
);

    
     parameter EMPTY = 3'b000;
     parameter PAWN = 3'b001;
     parameter BISHOP = 3'b010;
     parameter KNIGHT = 3'b011;  
     parameter ROOK = 3'b100;
     parameter QUEEN = 3'b101;
     parameter KING = 3'b110;
     parameter AVAILABLE = 3'b111;
     
     parameter WHITE = 1'b0;
     parameter BLACK = 1'b1;
     
     parameter BLACK_PIECE = 16'b00000_000000_00000;    //it's black
     parameter WHITE_PIECE = 16'b10110_101101_10110;    // it's grey
     
     parameter BLACK_SQ = 16'b10010_010011_00010;       //it's brown
     parameter WHITE_SQ = 16'b11111_111111_11111;       //it's white
     parameter AVAIL_SQ = 16'b11011_011101_10001;        //it flashes pink when it's available
     
    
//     reg [3:0] chess_board [7:0][7:0];
     reg [3:0] chess_board[63:0];
     integer i, j;
     wire[8:0] d;
     assign d = ((j * 8) + i);
     
     wire [12:0] x, y;
     idxToCoord idxToCoord_unit (pix_index, x, y);
     

    wire [8:0] x_coord, y_coord;     
     reg black_square = 0;
     
//     wire [31:0] count_6p25 = 7;
//     wire clk_6p25;
//     flexible_clock clk6p25m (.basys_clk(clock), .count_in(count_6p25), .out_clk(clk_6p25));
     
//     wire [31:0] count_6p25_ = 10000;
//      wire clk_6p25_;
//      flexible_clock clk6p25_m (.basys_clk(clock), .count_in(count_6p25_), .out_clk(clk_6p25_));
     
     
     //setting up the array
      initial 
      begin
            chess_board[0] <= {BLACK, ROOK};
            chess_board[1] <= {BLACK, KNIGHT};
            chess_board[2] <= {BLACK, BISHOP};
              chess_board[3] <= {BLACK, KING};
              chess_board[4] <= {BLACK, QUEEN};
              chess_board[5] <= {BLACK, BISHOP};
              chess_board[6] <= {BLACK, KNIGHT};
              chess_board[7] <= {BLACK, ROOK};
//          chess_board[0][2:0] <= ROOK;
//          chess_board[0][3] <= BLACK;
//          chess_board[1][2:0] <= KNIGHT;
//          chess_board[1][3] <= BLACK;
//          chess_board[2][2:0] <= BISHOP;
//          chess_board[2][3] <= BLACK;
//          chess_board[3][2:0] <= KING;
//          chess_board[3][3] <= BLACK;
//          chess_board[4][2:0] <= QUEEN;
//          chess_board[4][3] <= BLACK;
//          chess_board[5][2:0] <= BISHOP;
//          chess_board[5][3] <= BLACK;
//          chess_board[6][2:0] <= KNIGHT;
//          chess_board[6][3] <= BLACK;
//          chess_board[7][2:0] <= ROOK;
//          chess_board[7][3] <= BLACK;
          
//          chess_board[8][2:0] <= PAWN;
//          chess_board[8][3] <= BLACK;
//          chess_board[9][2:0] <= PAWN;
//          chess_board[9][3] <= BLACK;
//          chess_board[10][2:0] <= PAWN;
//          chess_board[10][3] <= BLACK;
//          chess_board[11][2:0] <= PAWN;
//          chess_board[11][3] <= BLACK;
//          chess_board[12][2:0] <= PAWN;
//          chess_board[12][3] <= BLACK;
//          chess_board[13][2:0] <= PAWN;
//          chess_board[13][3] <= BLACK;
//          chess_board[14][2:0] <= PAWN;
//          chess_board[14][3] <= BLACK;
//          chess_board[15][2:0] <= PAWN;
//          chess_board[15][3] <= BLACK;
          
          chess_board[16][2:0] <= EMPTY;
          chess_board[16][3] <= BLACK;
          chess_board[17][2:0] <= EMPTY;
          chess_board[17][3] <= BLACK;
          chess_board[18][2:0] <= EMPTY;
          chess_board[18][3] <= BLACK;
          chess_board[19][2:0] <= EMPTY;
          chess_board[19][3] <= BLACK;
          chess_board[20][2:0] <= EMPTY;
          chess_board[20][3] <= BLACK;
          chess_board[21][2:0] <= EMPTY;
          chess_board[21][3] <= BLACK;
          chess_board[22][2:0] <= EMPTY;
          chess_board[22][3] <= BLACK;
          chess_board[23][2:0] <= EMPTY;
          chess_board[23][3] <= BLACK;
     
          chess_board[24][2:0] <= EMPTY;
          chess_board[24][3] <= BLACK;
          chess_board[25][2:0] <= EMPTY;
          chess_board[25][3] <= BLACK;
          chess_board[26][2:0] <= EMPTY;
          chess_board[26][3] <= BLACK;
          chess_board[27][2:0] <= EMPTY;
          chess_board[27][3] <= BLACK;
          chess_board[28][2:0] <= EMPTY;
          chess_board[28][3] <= BLACK;
          chess_board[29][2:0] <= EMPTY;
          chess_board[29][3] <= BLACK;
          chess_board[30][2:0] <= EMPTY;
          chess_board[30][3] <= BLACK;
          chess_board[31][2:0] <= EMPTY;
          chess_board[31][3] <= BLACK;     
    
          chess_board[32][2:0] <= EMPTY;
          chess_board[32][3] <= BLACK;
          chess_board[33][2:0] <= EMPTY;
          chess_board[33][3] <= BLACK;
          chess_board[34][2:0] <= EMPTY;
          chess_board[34][3] <= BLACK;
          chess_board[35][2:0] <= EMPTY;
          chess_board[35][3] <= BLACK;
          chess_board[36][2:0] <= EMPTY;
          chess_board[36][3] <= BLACK;
          chess_board[37][2:0] <= EMPTY;
          chess_board[37][3] <= BLACK;
          chess_board[38][2:0] <= EMPTY;
          chess_board[38][3] <= BLACK;
          chess_board[39][2:0] <= EMPTY;
          chess_board[39][3] <= BLACK;      
    
          chess_board[40][2:0] <= EMPTY;
          chess_board[40][3] <= BLACK;
          chess_board[41][2:0] <= EMPTY;
          chess_board[41][3] <= BLACK;
          chess_board[42][2:0] <= EMPTY;
          chess_board[42][3] <= BLACK;
          chess_board[43][2:0] <= EMPTY;
          chess_board[43][3] <= BLACK;
          chess_board[44][2:0] <= EMPTY;
          chess_board[44][3] <= BLACK;
          chess_board[45][2:0] <= EMPTY;
          chess_board[45][3] <= BLACK;
          chess_board[46][2:0] <= EMPTY;
          chess_board[46][3] <= BLACK;
          chess_board[47][2:0] <= EMPTY;
          chess_board[47][3] <= BLACK;     
          
//          chess_board[48][2:0] <= PAWN;
//          chess_board[48][3] <= WHITE;
//          chess_board[49][2:0] <= PAWN;
//          chess_board[49][3] <= WHITE;
//          chess_board[50][2:0] <= PAWN;
//          chess_board[50][3] <= WHITE;
//          chess_board[51][2:0] <= PAWN;
//          chess_board[51][3] <= WHITE;
//          chess_board[52][2:0] <= PAWN;
//          chess_board[52][3] <= WHITE;
//          chess_board[53][2:0] <= PAWN;
//          chess_board[53][3] <= WHITE;
//          chess_board[54][2:0] <= PAWN;
//          chess_board[54][3] <= WHITE;
//          chess_board[55][2:0] <= PAWN;
//          chess_board[55][3] <= WHITE;      
          
//          chess_board[56][2:0] <= ROOK;
//          chess_board[56][3] <= WHITE;
//          chess_board[57][2:0] <= KNIGHT;
//          chess_board[57][3] <= WHITE;
//          chess_board[58][2:0] <= BISHOP;
//          chess_board[58][3] <= WHITE;
//          chess_board[59][2:0] <= KING;
//          chess_board[59][3] <= WHITE;
//          chess_board[60][2:0] <= QUEEN;
//          chess_board[60][3] <= WHITE;
//          chess_board[61][2:0] <= BISHOP;
//          chess_board[61][3] <= WHITE;
//          chess_board[62][2:0] <= KNIGHT;
//          chess_board[62][3] <= WHITE;
//          chess_board[63][2:0] <= ROOK;
//          chess_board[63][3] <= WHITE;
          
       end
      
      integer avail_x = 0;
      integer avail_y = 0;
      integer c;
      reg [63:0]avail_array = 0;
      
      wire[8:0]old_b, new_b;
        assign old_b = ((old_y * 8) + old_x);
        assign new_b = ((new_y * 8) + new_x);
            
      
      //updating the new square
//      always @ (new_b)
//      begin
//        chess_board[old_b][2:0] <= EMPTY;
//        chess_board[new_b][2:0] <= state;
//        chess_board[new_b][3] <= colour;
        
//        avail_array <= in_avail_array;
////        for (c = 0; c < 64; c = c + 1)
////        begin
////            if (avail_array[c] == 1)
////            begin
////                avail_x <= (c % 8);
////                avail_y <= (c / 64) * 8;
////                chess_board[avail_x][avail_y][2:0] <= AVAILABLE;
//            end
//         end
//      end
       
       reg [31:0] count_x = 0;
       reg [31:0] count_y = 0;
//       wire [31:0] b;
//       assign b = ((count_y * 8) + count_x);
        reg [31:0] b;
       
       assign x_coord = (count_x * 8) + 16;
       assign y_coord = (count_y * 8);
       
       reg [26:0]counter = 1;
       reg [1:0]flash_colour = 0;
       //drawing the pieces
       always @ (posedge clock)
       begin

           count_y <= (count_y == 7) ? 0 : count_y + 1;
            
           if (count_y == 7)
           begin
               count_x <= (count_x == 7) ? 0 : count_x + 1;
           end
           b <= ((count_y * 8) + count_x);
            
//           if (chess_board[b][2:0] == PAWN && 
//               (((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) || 
//               ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
//               ((y == y_coord + 3) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
//               ((y >= y_coord + 4 && y <= y_coord + 6) && (x == x_coord + 3 || x == x_coord + 4)) ||
//               ((y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6))) )
//           begin
//                if (chess_board[b][3] == BLACK)
//                begin
//                    oled_data <= BLACK_PIECE;
//                end
//                else begin
//                    oled_data <= WHITE_PIECE;
//                end
//           end
             
//             if (chess_board[0][2:0] == ROOK &&
//                    ( ((y == y_coord + 1) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
//                    ((y == y_coord + 2 || y == y_coord + 3 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
//                    ((y == y_coord + 4 || y == y_coord + 5) && (x == x_coord + 3 || x == x_coord + 4)) ||
//                    ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
            if (chess_board[b] == {BLACK, ROOK} &&
                    ( ((y == y_coord + 1) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
                    ((y == y_coord + 2 || y == y_coord + 3 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                    ((y == y_coord + 4 || y == y_coord + 5) && (x == x_coord + 3 || x == x_coord + 4)) ||
                    ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))

                    begin
//                    if (chess_board[0][3] == BLACK)
//                    begin
                        oled_data <= BLACK_PIECE;
//                    end
//                    else begin
//                        oled_data <= WHITE_PIECE;
//                    end 
              end
              
              else if (chess_board[b] == {BLACK, BISHOP} &&
                    ( ((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) ||
                    ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
                    ((y == y_coord + 3) && ((x >= x_coord + 1 && x <= x_coord + 4) || x == x_coord + 6)) ||
                    ((y == y_coord + 4) && ((x >= x_coord + 1 && x <= x_coord + 3) || x == x_coord + 5 || x == x_coord + 6)) ||
                    ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                    ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                    begin
//                        if (chess_board[b][3] == BLACK)
//                        begin
                            oled_data <= BLACK_PIECE;
//                        end
//                        else begin
//                            oled_data <= WHITE_PIECE;
//                        end 
              end
              
              else if (chess_board[b] == {BLACK, KNIGHT} &&
                    ( ((y == y_coord + 1) && (x == x_coord + 3)) ||
                    ((y == y_coord + 2) && (x == x_coord >= 2 && x == x_coord <= 5)) ||
                    ((y == y_coord + 3) && (x == x_coord + 1 || (x >= x_coord + 3 && x <= x_coord + 6))) ||
                    ((y == y_coord + 4 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                    ((y == y_coord + 5) && (x == x_coord + 1 || (x >= x_coord + 4 && x <= x_coord + 6))) ||
                    ((y == y_coord + 6) && (x >= x_coord + 3 && x <= x_coord + 5)) ))
                    begin
//                        if (chess_board[b][3] == BLACK)
//                        begin
                            oled_data <= BLACK_PIECE;
//                        end
//                        else begin
//                            oled_data <= WHITE_PIECE;
//                        end 
              end              
                
                
              else if (chess_board[b] == {BLACK, QUEEN} &&
                  (((y == y_coord + 2 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                  ((y == y_coord + 3 || y == y_coord + 4) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
                  ((y == y_coord + 5) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                    begin
//                        if (chess_board[b][3] == BLACK)
//                        begin
                            oled_data <= BLACK_PIECE;
//                        end
//                        else begin
//                            oled_data <= WHITE_PIECE;
//                        end 
              end                              
       
       
       
              else if (chess_board[b] == {BLACK, KING} &&
                   ( ((y == y_coord + 1 || y == y_coord + 3 || y == y_coord + 4) &&
                   (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
                   ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                   ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                    begin
//                        if (chess_board[b][3] == BLACK)
//                        begin
                            oled_data <= BLACK_PIECE;
//                        end
//                        else begin
//                            oled_data <= WHITE_PIECE;
//                        end 
                    end
                    
                    
            else if (x < 16 || x > 80)
            begin
              oled_data <= BLACK_PIECE;   //black
            end
            
            else if (x >= x_coord && x < x_coord + 8 && y >= y_coord && y < y_coord + 8)
             begin 
                 if (((count_x + count_y) % 2) == 0)       //if it's the row + col is even, the square is white, if it's odd it's black
                 begin
                      oled_data <= WHITE_SQ;
                 end
                 else begin
                      oled_data <= BLACK_SQ;

                  end
              end
    end
      
   
endmodule