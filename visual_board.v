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

/*
module board_art (
    input clock, old_x, old_y, new_x, new_y, color, input [2:0] state, input [12:0] pix_index,
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
    parameter WHITE_PIECE = 16'b11010_110101_11010;    // it's grey
    
    parameter BLACK_SQ = 16'b10010_010011_00010;       //it's brown
    parameter WHITE_SQ = 16'b11111_111111_11111;       //it's white
    parameter AVAIL_SQ = 16'b11111_101101_1100;        //it flashes pink when it's available
    
    reg [3:0] chess_board [7:0][7:0];
    //     reg [3:0] i;
    //     reg [3:0] j;
    integer i, j;
     
    wire [12:0] x, y;
    idxToCoord idxToCoord_unit (pix_index, x, y);
     
//     reg [8:0] x_coord, y_coord;
    wire [8:0] x_coord, y_coord;     
    reg black_square = 0;
    
    reg [31:0] count_x = 0;
    reg [31:0] count_y = 0;
   
    assign x_coord = (count_x * 8) + 17;
    assign y_coord = (count_y * 8);
   
    reg [26:0]counter = 1;
    reg [1:0]flash_colour = 0;

    
    wire [31:0] count_6p25 = 7;
    wire clk_6p25;
    flexible_clock clk6p25m (.basys_clk(clock), .count_in(count_6p25), .out_clk(clk_6p25));

    always @ (posedge clock)
    begin
    
        count_y <= (count_y == 7) ? 0 : count_y + 1;
        
        if (count_y == 7)
        begin
            count_x <= (count_x == 7) ? 0 : count_x + 1;
        end
        
//            if (chess_board[count_x][count_y][2:0] == PAWN && 
//                    (((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) || 
//                    ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
//                    ((y == y_coord + 3) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
//                    ((y >= y_coord + 4 && y <= y_coord + 6) && (x == x_coord + 3 || x == x_coord + 4)) ||
//                    ((y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6))) )
//                     begin
//                        if (chess_board[count_x][count_y][3] == BLACK)
//                        begin
//                            oled_data <= BLACK_PIECE;
//                        end
//                        else begin
//                            oled_data <= WHITE_PIECE;
//                        end
//             end
         
//             if (chess_board[count_x][count_y][2:0] == ROOK &&
//                    ( ((y == y_coord + 1) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
//                    ((y == y_coord + 2 || y == y_coord + 3 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
//                    ((y == y_coord + 4 || y == y_coord + 5) && (x == x_coord + 3 || x == x_coord + 4)) ||
//                    ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
//         if (( ((y == y_coord + 1) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
//                ((y == y_coord + 2 || y == y_coord + 3 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
//                ((y == y_coord + 4 || y == y_coord + 5) && (x == x_coord + 3 || x == x_coord + 4)) ||
//                ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
//                begin
////                        oled_data <= WHITE_PIECE;
//                    if (chess_board[count_x][count_y][3] == BLACK)
//                    begin
//                        oled_data <= BLACK_PIECE;
//                    end
//                    else begin
//                        oled_data <= WHITE_PIECE;
//                    end 
//          end
          
//          else if (chess_board[count_x][count_y][2:0] == BISHOP &&
//                ( ((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) ||
//                ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
//                ((y == y_coord + 3) && ((x >= x_coord + 1 && x <= x_coord + 4) || x == x_coord + 6)) ||
//                ((y == y_coord + 4) && ((x >= x_coord + 1 && x <= x_coord + 3) || x == x_coord + 5 || x == x_coord + 6)) ||
//                ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
//                ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
//                begin
//                    if (chess_board[count_x][count_y][3] == BLACK)
//                    begin
//                        oled_data <= BLACK_PIECE;
//                    end
//                    else begin
//                        oled_data <= WHITE_PIECE;
//                    end 
//          end
          
//          else if (chess_board[count_x][count_y][2:0] == KNIGHT &&
//                ( ((y == y_coord + 1) && (x == x_coord + 3)) ||
//                ((y == y_coord + 2) && (x == x_coord >= 2 && x == x_coord <= 5)) ||
//                ((y == y_coord + 3) && (x == x_coord + 1 || (x >= x_coord + 3 && x <= x_coord + 6))) ||
//                ((y == y_coord + 4 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
//                ((y == y_coord + 5) && (x == x_coord + 1 || (x >= x_coord + 4 && x <= x_coord + 6))) ||
//                ((y == y_coord + 6) && (x >= x_coord + 3 && x <= x_coord + 5)) ))
//                begin
//                    if (chess_board[count_x][count_y][3] == BLACK)
//                    begin
//                        oled_data <= BLACK_PIECE;
//                    end
//                    else begin
//                        oled_data <= WHITE_PIECE;
//                    end 
//          end              
            
            
//          else if (chess_board[count_x][count_y][2:0] == QUEEN &&
//              (((y == y_coord + 2 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
//              ((y == y_coord + 3 || y == y_coord + 4) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
//              ((y == y_coord + 5) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
//                begin
//                    if (chess_board[count_x][count_y][3] == BLACK)
//                    begin
//                        oled_data <= BLACK_PIECE;
//                    end
//                    else begin
//                        oled_data <= WHITE_PIECE;
//                    end 
//          end                              
   
   
   
//          else if (chess_board[count_x][count_y][2:0] == KING &&
//               ( ((y == y_coord + 1 || y == y_coord + 3 || y == y_coord + 4) &&
//               (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
//               ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
//               ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
//                begin
//                    if (chess_board[count_x][count_y][3] == BLACK)
//                    begin
//                        oled_data <= BLACK_PIECE;
//                    end
//                    else begin
//                        oled_data <= WHITE_PIECE;
//                    end 
//                end
        
        else if (x >= x_coord && x < x_coord + 8 && y >= y_coord && y < y_coord + 8)
         begin 
             if (((count_x + count_y) % 2) == 0)       //if it's the row + col is even, the square is white, if it's odd it's black
//                if (count_x + count_y == 0 || count_x + count_y == 2 || count_x + count_y == 4)
             begin
                  oled_data <= WHITE_SQ;
//                       oled_data <= 16'b11111_111111_10110;
             end
             else begin
                  oled_data <= BLACK_SQ;
//                       oled_data <= 16'b00000_000000_00000;
              end
          end
    end
endmodule
*/

//module board_art (
//    input clock,
//    input old_x, old_y, new_x, new_y,
//    input [2:0] state,
//    input [1:0] colour, //0 for white, 1 for black
//    input [63:0] in_avail_arary,
//    input [12:0] pix_index,
//    output reg [15:0] oled_data
//    );

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
     parameter WHITE_PIECE = 16'b11010_110101_11010;    // it's grey
     
     parameter BLACK_SQ = 16'b10010_010011_00010;       //it's brown
     parameter WHITE_SQ = 16'b11111_111111_11111;       //it's white
     parameter AVAIL_SQ = 16'b11111_101101_1100;        //it flashes pink when it's available
     
    
     reg [3:0] chess_board [7:0][7:0];
//     reg [3:0] i;
//     reg [3:0] j;
     integer i, j;
     
     wire [12:0] x, y;
     idxToCoord idxToCoord_unit (pix_index, x, y);
     
//     reg [8:0] x_coord, y_coord;
    wire [8:0] x_coord, y_coord;     
     reg black_square = 0;
     
     wire [31:0] count_6p25 = 7;
     wire clk_6p25;
     flexible_clock clk6p25m (.basys_clk(clock), .count_in(count_6p25), .out_clk(clk_6p25));
     
     wire [31:0] count_6p25_ = 10000;
      wire clk_6p25_;
      flexible_clock clk6p25_m (.basys_clk(clock), .count_in(count_6p25_), .out_clk(clk_6p25_));
     
     
     //setting up the 2d array
     initial begin
     for (i = 0; i <= 7; i = i+ 1)
     begin
        for (j = 0; j <= 7; j = j + 1)
        begin
        
            if (i >= 2 && i <= 5)
            begin
                chess_board[i][j][2:0] <= EMPTY;
            end
            
            else if (i == 1)
            begin
                chess_board[i][j][2:0] <= PAWN;  
                chess_board[i][j][3] <= BLACK;
            end
            
            else if (i == 6)
            begin
                chess_board[i][j][2:0] <= PAWN; //white
                chess_board[i][j] <= WHITE;
            end
            
            else if (i == 0)
            begin
                if (j == 0 || j == 7)
                begin
                    chess_board[i][j][2:0] <= ROOK;
                    chess_board[i][j][3] <= BLACK;
                end
                
                else if (j == 1 || j == 6)
                begin
                    chess_board[i][j][2:0] <= KNIGHT;
                    chess_board[i][j][3] <= BLACK;
                end
                
                else if (j == 3 || j == 5)
                begin
                    chess_board[i][j][2:0] <= BISHOP;
                    chess_board[i][j][3] <= BLACK;
                end
                
                else if (j == 4)
                begin
                    chess_board[i][j][2:0] <= KING;
                    chess_board[i][j][3] <= BLACK;
                end
                
                else if (j == 5)
                begin
                    chess_board[i][j][2:0] <= QUEEN;
                    chess_board[i][j][3] <= BLACK;
                end
              end
               
           else if (i == j)
           begin
               if (j == 0 || j == 7)
               begin
                   chess_board[i][j][2:0] <= ROOK;
                   chess_board[i][j][3] <= WHITE;
               end
               
               else if (j == 1 || j == 6)
               begin
                   chess_board[i][j][2:0] <= KNIGHT;
                   chess_board[i][j][3] <= WHITE;
               end
               
               else if (j == 3 || j == 5)
               begin
                   chess_board[i][j][2:0] <= BISHOP;
                   chess_board[i][j][3] <= WHITE;
               end
               
               else if (j == 4)
               begin
                   chess_board[i][j][2:0] <= KING;
                   chess_board[i][j][3] <= WHITE;
               end
                
               else if (j == 5)
               begin
                   chess_board[i][j][2:0] <= QUEEN;
                   chess_board[i][j][3] <= WHITE;
               end
             end
             
         end
        end
      end
      
      integer avail_x = 0;
      integer avail_y = 0;
      integer c;
      reg [63:0]avail_array = 0;
      
      //updating the new square
      always @ (posedge clock)
      begin
        chess_board[old_y][old_x][2:0] <= EMPTY;
        chess_board[new_y][new_x][2:0] <= state;
        chess_board[new_y][new_x][3] <= colour;
        
        avail_array <= in_avail_array;
//        for (c = 0; c < 64; c = c + 1)
//        begin
//            if (avail_array[c] == 1)
//            begin
//                avail_x <= (c % 8);
//                avail_y <= (c / 64) * 8;
//                chess_board[avail_x][avail_y][2:0] <= AVAILABLE;
//            end
//         end
      end
       
       reg [31:0] count_x = 0;
       reg [31:0] count_y = 0;
       
       
       assign x_coord = (count_x * 8) + 17;
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
            
           if (chess_board[count_x][count_y][2:0] == PAWN && 
               (((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) || 
               ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
               ((y == y_coord + 3) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
               ((y >= y_coord + 4 && y <= y_coord + 6) && (x == x_coord + 3 || x == x_coord + 4)) ||
               ((y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6))) )
           begin
                if (chess_board[count_x][count_y][3] == BLACK)
                begin
                    oled_data <= BLACK_PIECE;
                end
                else begin
                    oled_data <= WHITE_PIECE;
                end
           end
             
             else if (chess_board[count_x][count_y][2:0] == ROOK &&
                    ( ((y == y_coord + 1) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
                    ((y == y_coord + 2 || y == y_coord + 3 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                    ((y == y_coord + 4 || y == y_coord + 5) && (x == x_coord + 3 || x == x_coord + 4)) ||
                    ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
//             if (( ((y == y_coord + 1) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
//                    ((y == y_coord + 2 || y == y_coord + 3 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
//                    ((y == y_coord + 4 || y == y_coord + 5) && (x == x_coord + 3 || x == x_coord + 4)) ||
//                    ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                    begin
//                        oled_data <= WHITE_PIECE;
                    if (chess_board[count_x][count_y][3] == BLACK)
                    begin
                        oled_data <= BLACK_PIECE;
                    end
                    else begin
                        oled_data <= WHITE_PIECE;
                    end 
              end
              
              else if (chess_board[count_x][count_y][2:0] == BISHOP &&
                    ( ((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) ||
                    ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
                    ((y == y_coord + 3) && ((x >= x_coord + 1 && x <= x_coord + 4) || x == x_coord + 6)) ||
                    ((y == y_coord + 4) && ((x >= x_coord + 1 && x <= x_coord + 3) || x == x_coord + 5 || x == x_coord + 6)) ||
                    ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                    ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                    begin
                        if (chess_board[count_x][count_y][3] == BLACK)
                        begin
                            oled_data <= BLACK_PIECE;
                        end
                        else begin
                            oled_data <= WHITE_PIECE;
                        end 
              end
              
              else if (chess_board[count_x][count_y][2:0] == KNIGHT &&
                    ( ((y == y_coord + 1) && (x == x_coord + 3)) ||
                    ((y == y_coord + 2) && (x == x_coord >= 2 && x == x_coord <= 5)) ||
                    ((y == y_coord + 3) && (x == x_coord + 1 || (x >= x_coord + 3 && x <= x_coord + 6))) ||
                    ((y == y_coord + 4 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                    ((y == y_coord + 5) && (x == x_coord + 1 || (x >= x_coord + 4 && x <= x_coord + 6))) ||
                    ((y == y_coord + 6) && (x >= x_coord + 3 && x <= x_coord + 5)) ))
                    begin
                        if (chess_board[count_x][count_y][3] == BLACK)
                        begin
                            oled_data <= BLACK_PIECE;
                        end
                        else begin
                            oled_data <= WHITE_PIECE;
                        end 
              end              
                
                
              else if (chess_board[count_x][count_y][2:0] == QUEEN &&
                  (((y == y_coord + 2 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                  ((y == y_coord + 3 || y == y_coord + 4) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
                  ((y == y_coord + 5) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                    begin
                        if (chess_board[count_x][count_y][3] == BLACK)
                        begin
                            oled_data <= BLACK_PIECE;
                        end
                        else begin
                            oled_data <= WHITE_PIECE;
                        end 
              end                              
       
       
       
              else if (chess_board[count_x][count_y][2:0] == KING &&
                   ( ((y == y_coord + 1 || y == y_coord + 3 || y == y_coord + 4) &&
                   (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
                   ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                   ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                    begin
                        if (chess_board[count_x][count_y][3] == BLACK)
                        begin
                            oled_data <= BLACK_PIECE;
                        end
                        else begin
                            oled_data <= WHITE_PIECE;
                        end 
                    end
            
            else if (x >= x_coord && x < x_coord + 8 && y >= y_coord && y < y_coord + 8)
             begin 
                 if (((count_x + count_y) % 2) == 0)       //if it's the row + col is even, the square is white, if it's odd it's black
//                if (count_x + count_y == 0 || count_x + count_y == 2 || count_x + count_y == 4)
                 begin
                      oled_data <= WHITE_SQ;
//                       oled_data <= 16'b11111_111111_10110;
                 end
                 else begin
                      oled_data <= BLACK_SQ;
//                       oled_data <= 16'b00000_000000_00000;
                  end
              end
    end
      
   
endmodule


//       for (i = 0; i <= 7; i = i+ 1)
//       begin
//          for (j = 0; j <= 7; j = j + 1)
//          begin
//            x_coord <= (j * 8) + 16;
//            y_coord <= (i * 8);
            
//            if (chess_board[i][j][2:0] == AVAILABLE && ((x >= x_coord || x < x_coord + 8) && (y >= y_coord || y < y_coord + 8)) )
//            begin
//                oled_data <= (flash_colour) ? AVAIL_SQ : ((i + j) % 2 == 0) ? WHITE_SQ : BLACK_SQ;
//                flash_colour <= (counter == 0) ? ~flash_colour : flash_colour;
//                counter <= (counter >= 25_000_000) ? 0 : counter + 1;
//            end

//             if (chess_board[i][j][2:0] == PAWN && 
//                    (((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) || 
//                    ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
//                    ((y == y_coord + 3) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
//                    ((y >= y_coord + 4 && y <= y_coord + 6) && (x == x_coord + 3 || x == x_coord + 4)) ||
//                    ((y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6))) )
//                     begin
//                        if (chess_board[i][j][3] == BLACK)
//                        begin
//                            oled_data <= BLACK_PIECE;
//                        end
//                        else begin
//                            oled_data <= WHITE_PIECE;
//                        end
//             end
             
//             else if (chess_board[i][j][2:0] == ROOK &&
//                    ( ((y == y_coord + 1) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
//                    ((y == y_coord + 2 || y == y_coord + 3 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
//                    ((y == y_coord + 4 || y == y_coord + 5) && (x == x_coord + 3 || x == x_coord + 4)) ||
//                    ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
//                    begin
//                        if (chess_board[i][j][3] == BLACK)
//                        begin
//                            oled_data <= BLACK_PIECE;
//                        end
//                        else begin
//                            oled_data <= WHITE_PIECE;
//                        end 
//              end
              
//              else if (chess_board[i][j][2:0] == BISHOP &&
//                    ( ((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) ||
//                    ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
//                    ((y == y_coord + 3) && ((x >= x_coord + 1 && x <= x_coord + 4) || x == x_coord + 6)) ||
//                    ((y == y_coord + 4) && ((x >= x_coord + 1 && x <= x_coord + 3) || x == x_coord + 5 || x == x_coord + 6)) ||
//                    ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
//                    ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
//                    begin
//                        if (chess_board[i][j][3] == BLACK)
//                        begin
//                            oled_data <= BLACK_PIECE;
//                        end
//                        else begin
//                            oled_data <= WHITE_PIECE;
//                        end 
//              end
              
//              else if (chess_board[i][j][2:0] == KNIGHT &&
//                    ( ((y == y_coord + 1) && (x == x_coord + 3)) ||
//                    ((y == y_coord + 2) && (x == x_coord >= 2 && x == x_coord <= 5)) ||
//                    ((y == y_coord + 3) && (x == x_coord + 1 || (x >= x_coord + 3 && x <= x_coord + 6))) ||
//                    ((y == y_coord + 4 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
//                    ((y == y_coord + 5) && (x == x_coord + 1 || (x >= x_coord + 4 && x <= x_coord + 6))) ||
//                    ((y == y_coord + 6) && (x >= x_coord + 3 && x <= x_coord + 5)) ))
//                    begin
//                        if (chess_board[i][j][3] == BLACK)
//                        begin
//                            oled_data <= BLACK_PIECE;
//                        end
//                        else begin
//                            oled_data <= WHITE_PIECE;
//                        end 
//              end              
                
                
//              else if (chess_board[i][j][2:0] == QUEEN &&
//                  (((y == y_coord + 2 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
//                  ((y == y_coord + 3 || y == y_coord + 4) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
//                  ((y == y_coord + 5) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
//                    begin
//                        if (chess_board[i][j][3] == BLACK)
//                        begin
//                            oled_data <= BLACK_PIECE;
//                        end
//                        else begin
//                            oled_data <= WHITE_PIECE;
//                        end 
//              end                              
       
       
       
//              else if (chess_board[i][j][2:0] == KING &&
//                   ( ((y == y_coord + 1 || y == y_coord + 3 || y == y_coord + 4) &&
//                   (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
//                   ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
//                   ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
//                    begin
//                        if (chess_board[i][j][3] == BLACK)
//                        begin
//                            oled_data <= BLACK_PIECE;
//                        end
//                        else begin
//                            oled_data <= WHITE_PIECE;
//                        end 
//              end
              
                          
//               if (((x >= x_coord || x < x_coord + 8) && (y >= y_coord || y < y_coord + 8)) )
//              if (((x >= x_coord && x < x_coord + 8) && (y >= y_coord && y < y_coord + 8)) )
//              begin 
//                  if (((i + j) % 2) == 0)       //if it's the row + col is even, the square is white, if it's odd it's black
//                  begin
////                      oled_data <= WHITE_SQ;
//                        oled_data <= 16'b11111_111111_11111;
//                  end
//                  else begin
////                      oled_data <= BLACK_SQ;
//                        oled_data <= 16'b00000_000000_00000;
//                   end
//               end
  
       
//       end
//       end

