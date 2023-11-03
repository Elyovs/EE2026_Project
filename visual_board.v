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
    input clock, player,
    input [5:0]old_x, old_y, new_x, new_y, 
    input [1:0]colour, //0 for white, 1 for black
    input [2:0] state, 
    input [12:0] pix_index,
    input [63:0] in_avail_array,
    output reg [15:0] oled_data,
    inout PS2Clk, inout PS2Data,
    output reg [15:0] led
);

//__________________________________________________________________
    //mouse
    wire [11:0] x_pos, y_pos;
    wire [3:0] z_pos;
    wire [2:0] lmr;
    wire n_event;
    
    MouseCtl mouse1(
        .clk(clock), 
        .rst(0), 
        .value(0), 
        .setx(0), 
        .sety(0), 
        .setmax_x(0), 
        .setmax_y(0), 
        .xpos(x_pos),
        .ypos(y_pos),
        .zpos(z_pos),
        .left(lmr[2]),
        .middle(lmr[1]),
        .right(lmr[0]),
        .new_event(n_event),
        .ps2_clk(PS2Clk),
        .ps2_data(PS2Data)
    );
//__________________________________________________________________    

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
     parameter WHITE_PIECE = 16'b11011_011101_10001;    // it's pink
     
     parameter BLACK_SQ = 16'b10010_010011_00010;       //it's brown
     parameter WHITE_SQ = 16'b11111_111111_11111;       //it's white
     parameter AVAIL_SQ = 16'b11110_111111_00010;        //it flashes yellow when it's available
     
     //_______________________________________________________________
     parameter BLACK_CURSOR = 16'b00000_000000_00000;
     parameter LIGHT_BLUE = 16'b01111_110111_10111;
     
     reg cursor_x, cursor_y;
     //____________________________________________________________
     
    
     //reg [3:0] chess_board [7:0][7:0];
     reg [3:0] chess_board[63:0];
     integer i, j;
     wire[8:0] d;
     assign d = ((j * 8) + i);
     
     wire [12:0] x, y;
     idxToCoord idxToCoord_unit (pix_index, x, y);
    

    wire [12:0] x_coord, y_coord;     
     reg black_square = 0;
     
     wire [31:0] count_6p25 = 7;
     wire clk_6p25;
     flexible_clock clk6p25m (.basys_clk(clock), .count_in(count_6p25), .out_clk(clk_6p25));
     
     wire [31:0] count_6p25_ = 10000;
      wire clk_6p25_;
      flexible_clock clk6p25_m (.basys_clk(clock), .count_in(count_6p25_), .out_clk(clk_6p25_));
     
     
     //setting up the array
      initial begin
      
      chess_board[0] <= {BLACK, ROOK};
      chess_board[1] <= {BLACK, KNIGHT};
      chess_board[2] <= {BLACK, BISHOP};
      chess_board[3] <= {BLACK, KING};
      chess_board[4] <= {BLACK, QUEEN};
      chess_board[5] <= {BLACK, BISHOP};
      chess_board[6] <= {BLACK, KNIGHT};
      chess_board[7] <= {BLACK, ROOK};
      
      chess_board[8] <= {BLACK, PAWN};
      chess_board[9] <= {BLACK, PAWN};
      chess_board[10] <= {BLACK, PAWN};
      chess_board[11] <= {BLACK, PAWN};
      chess_board[12] <= {BLACK, PAWN};
      chess_board[13] <= {BLACK, PAWN};
      chess_board[14] <= {BLACK, PAWN};
      chess_board[15] <= {BLACK, PAWN};    
      
      chess_board[16] <= {BLACK, EMPTY};
      chess_board[17] <= {BLACK, EMPTY};
      chess_board[18] <= {BLACK, EMPTY};
      chess_board[19] <= {BLACK, EMPTY};
      chess_board[20] <= {BLACK, EMPTY};
      chess_board[21] <= {BLACK, EMPTY};
      chess_board[22] <= {BLACK, EMPTY};
      chess_board[23] <= {BLACK, EMPTY};
      
      chess_board[24] <= {BLACK, EMPTY};
      chess_board[25] <= {BLACK, EMPTY};
      chess_board[26] <= {BLACK, EMPTY};
      chess_board[27] <= {BLACK, EMPTY};
      chess_board[28] <= {BLACK, EMPTY};
      chess_board[29] <= {BLACK, EMPTY};
      chess_board[30] <= {BLACK, EMPTY};
      chess_board[31] <= {BLACK, EMPTY};
      
      chess_board[32] <= {BLACK, EMPTY};
      chess_board[33] <= {BLACK, EMPTY};
      chess_board[34] <= {BLACK, EMPTY};
      chess_board[35] <= {BLACK, EMPTY};
      chess_board[36] <= {BLACK, EMPTY};
      chess_board[37] <= {BLACK, EMPTY};
      chess_board[38] <= {BLACK, EMPTY};
      chess_board[39] <= {BLACK, EMPTY}; 
      
      chess_board[40] <= {BLACK, EMPTY};
      chess_board[41] <= {BLACK, EMPTY};
      chess_board[42] <= {BLACK, EMPTY};
      chess_board[43] <= {BLACK, EMPTY};
      chess_board[44] <= {BLACK, EMPTY};
      chess_board[45] <= {BLACK, EMPTY};
      chess_board[46] <= {BLACK, EMPTY};
      chess_board[47] <= {BLACK, EMPTY};  
      
      chess_board[48] <= {WHITE, PAWN};
      chess_board[49] <= {WHITE, PAWN};
      chess_board[50] <= {WHITE, PAWN};
      chess_board[51] <= {WHITE, PAWN};
      chess_board[52] <= {WHITE, PAWN};
      chess_board[53] <= {WHITE, PAWN};
      chess_board[54] <= {WHITE, PAWN};
      chess_board[55] <= {WHITE, PAWN}; 
      
      chess_board[56] <= {WHITE, ROOK};
      chess_board[57] <= {WHITE, KNIGHT};
      chess_board[58] <= {WHITE, BISHOP};
      chess_board[59] <= {WHITE, KING};
      chess_board[60] <= {WHITE, QUEEN};
      chess_board[61] <= {WHITE, BISHOP};
      chess_board[62] <= {WHITE, KNIGHT};
      chess_board[63] <= {WHITE, ROOK};     
      
       end
       

      
      integer avail_x = 0;
      integer avail_y = 0;
      integer c;
      reg [63:0]avail_array = 0;
      
      wire[8:0]old_b, new_b;
        assign old_b = ((old_y * 8) + old_x);
        assign new_b = ((new_y * 8) + new_x);
            
      
      //updating the new square
      always @ (*)
      begin
      
//        chess_board[old_b][2:0] <= KING;
//        chess_board[old_b][3] <= 0;
//        chess_board[new_b][2:0] <= state;
//        chess_board[new_b][3] <= 1;
        
//        avail_array <= in_avail_array;
//        for (c = 0; c < 64; c = c + 1)
//        begin
//            if (avail_array[c] == 1)
//            begin
//                chess_board[c] <= {BLACK, AVAILABLE};
//            end
//         end
      end
       
       reg [31:0] count_x = 0;
       reg [31:0] count_y = 0;
       reg [31:0] b = 0;
//       assign b = ((count_y * 8) + count_x);
       
       assign x_coord = (count_x * 8) + 17;
       assign y_coord = (count_y * 8);
       
       reg [26:0] counter = 1;
       reg [1:0] flash_colour = 0;
       
       
       //drawing the pieces
       always @ (posedge clock)
       begin

           count_y <= (count_y >= 7) ? 0 : count_y + 1;
            
           if (count_y == 0)
           begin
               count_x <= (count_x >= 7) ? 0 : count_x + 1;
           end
           
           //______________________________________________________________________
           //board visual for player 1 and 2 - rotation
           if (player == 0) //player 1
           begin
                b <= (((count_y + 1) * 8) + count_x);
           end
           else b <= 63 - (((count_y + 1) * 8) + count_x);  //player 2
           //______________________________________________________________________
           
//           if (chess_board[b] == {BLACK, AVAILABLE} && ((x >= x_coord || x < x_coord + 8) && (y >= y_coord || y < y_coord + 8)) )
//           begin
//               oled_data <= (flash_colour) ? AVAIL_SQ : ((i + j) % 2 == 0) ? WHITE_SQ : BLACK_SQ;
//               flash_colour <= (counter == 0) ? ~flash_colour : flash_colour;
//               counter <= (counter >= 25_000_000) ? 0 : counter + 1;
//           end
           
           //mouse cursor
            if (((x >= x_pos - 1 && x <= x_pos + 1) && y == y_pos) || 
                (x == x_pos && (y >= y_pos - 1 && y <= y_pos + 1)))
            begin
                oled_data <= LIGHT_BLUE;
            end
            
            else if ((x == x_pos - 1 && (y == y_pos - 1 || y == y_pos + 1)) ||
                (x == x_pos + 1 && (y == y_pos - 1 || y == y_pos + 1)))
            begin
                oled_data <= BLACK_CURSOR;
            end
           
           
          if (chess_board[b] == {BLACK, PAWN} && 
              (((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) || 
              ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
              ((y == y_coord + 3) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
              ((y >= y_coord + 4 && y <= y_coord + 6) && (x == x_coord + 3 || x == x_coord + 4)) ||
              ((y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6))) )
          begin
                   oled_data <= BLACK_PIECE;
          end
           
          else if (chess_board[b] == {WHITE, PAWN} && 
              (((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) || 
              ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
              ((y == y_coord + 3) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
              ((y >= y_coord + 4 && y <= y_coord + 6) && (x == x_coord + 3 || x == x_coord + 4)) ||
              ((y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6))) )
          begin
                   oled_data <= WHITE_PIECE;
          end           
           
           
           
           else if (chess_board[b] == {BLACK, ROOK} &&
           ( ((y == y_coord + 1) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
           ((y == y_coord + 2 || y == y_coord + 3 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
           ((y == y_coord + 4 || y == y_coord + 5) && (x == x_coord + 3 || x == x_coord + 4)) ||
           ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
           begin
               oled_data <= BLACK_PIECE; 
            end
            
            
           else if (chess_board[b] == {WHITE, ROOK} &&
            ( ((y == y_coord + 1) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
            ((y == y_coord + 2 || y == y_coord + 3 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
            ((y == y_coord + 4 || y == y_coord + 5) && (x == x_coord + 3 || x == x_coord + 4)) ||
            ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
            begin
                oled_data <= WHITE_PIECE; 
             end
           
            else if (chess_board[b] == {BLACK, BISHOP} &&
                     ( ((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) ||
                     ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
                     ((y == y_coord + 3) && ((x >= x_coord + 1 && x <= x_coord + 4) || x == x_coord + 6)) ||
                     ((y == y_coord + 4) && ((x >= x_coord + 1 && x <= x_coord + 3) || x == x_coord + 5 || x == x_coord + 6)) ||
                     ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                     ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                     begin
                             oled_data <= BLACK_PIECE;          
                     end 
           
            else if (chess_board[b] == {WHITE, BISHOP} &&
                      ( ((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) ||
                      ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
                      ((y == y_coord + 3) && ((x >= x_coord + 1 && x <= x_coord + 4) || x == x_coord + 6)) ||
                      ((y == y_coord + 4) && ((x >= x_coord + 1 && x <= x_coord + 3) || x == x_coord + 5 || x == x_coord + 6)) ||
                      ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                      ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                      begin
                              oled_data <= WHITE_PIECE;          
                      end            
           
           
          else if (chess_board[b] == {BLACK, KNIGHT} &&
                    ( ((y == y_coord + 1) && (x == x_coord + 3)) ||
                    ((y == y_coord + 2) && (x == x_coord >= 2 && x == x_coord <= 5)) ||
                    ((y == y_coord + 3) && (x == x_coord + 1 || (x >= x_coord + 3 && x <= x_coord + 6))) ||
                    ((y == y_coord + 4 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                    ((y == y_coord + 5) && (x == x_coord + 1 || (x >= x_coord + 4 && x <= x_coord + 6))) ||
                    ((y == y_coord + 6) && (x >= x_coord + 3 && x <= x_coord + 5)) ))
                    begin
                            oled_data <= BLACK_PIECE;      
                    end     
           
          else if (chess_board[b] == {WHITE, KNIGHT} &&
                  ( ((y == y_coord + 1) && (x == x_coord + 3)) ||
                  ((y == y_coord + 2) && (x == x_coord >= 2 && x == x_coord <= 5)) ||
                  ((y == y_coord + 3) && (x == x_coord + 1 || (x >= x_coord + 3 && x <= x_coord + 6))) ||
                  ((y == y_coord + 4 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                  ((y == y_coord + 5) && (x == x_coord + 1 || (x >= x_coord + 4 && x <= x_coord + 6))) ||
                  ((y == y_coord + 6) && (x >= x_coord + 3 && x <= x_coord + 5)) ))
                  begin
                          oled_data <= WHITE_PIECE;      
                  end                
           
           
              else if (chess_board[b] == {BLACK, QUEEN} &&
                      (((y == y_coord + 2 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                      ((y == y_coord + 3 || y == y_coord + 4) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
                      ((y == y_coord + 5) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                        begin
                                oled_data <= BLACK_PIECE;
                        end                            
           
           
              else if (chess_board[b] == {WHITE, QUEEN} &&
                        (((y == y_coord + 2 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                        ((y == y_coord + 3 || y == y_coord + 4) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
                        ((y == y_coord + 5) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                          begin
                                  oled_data <= WHITE_PIECE;
                          end              
           
           
              else if (chess_board[b] == {BLACK, KING} &&
                       ( ((y == y_coord + 1 || y == y_coord + 3 || y == y_coord + 4) &&
                       (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
                       ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                       ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                        begin
                                oled_data <= BLACK_PIECE;
                        end           
 
              else if (chess_board[b] == {WHITE, KING} &&
                     ( ((y == y_coord + 1 || y == y_coord + 3 || y == y_coord + 4) &&
                     (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
                     ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                     ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                      begin
                              oled_data <= WHITE_PIECE;
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
           
           //__________________________________________________________________________
                if(lmr[2] && x_pos >= 17 && x_pos <= 24 && y_pos >= 0 && y_pos <= 63) 
                begin
                    cursor_x <= 0;
                end
                
                if(lmr[2] && x_pos >= 25 && x_pos <= 32 && y_pos >= 0 && y_pos <= 63) 
                begin
                    cursor_x <= 1;
                end
                if(lmr[2] && x_pos >= 33 && x_pos <= 40 && y_pos >= 0 && y_pos <= 63) 
                begin
                    cursor_x <= 2;
                end
                if(lmr[2] && x_pos >= 41 && x_pos <= 48 && y_pos >= 0 && y_pos <= 63)
                begin
                    cursor_x <= 3;
                end
                if(lmr[2] && x_pos >= 49 && x_pos <= 56 && y_pos >= 0 && y_pos <= 63)
                begin
                    cursor_x <= 4;
                end
                if(lmr[2] && x_pos >= 57 && x_pos <= 64 && y_pos >= 0 && y_pos <= 63) 
                begin
                    cursor_x <= 5;
                end
                if(lmr[2] && x_pos >= 65 && x_pos <= 72 && y_pos >= 0 && y_pos <= 63)
                begin
                    cursor_x <= 6;
                end
                if(lmr[2] && x_pos >= 73 && x_pos <= 80 && y_pos >= 0 && y_pos <= 63) 
                begin
                    cursor_x <= 7;
                end
                
                if(lmr[2] && y_pos >= 0 && y_pos <= 7 && x_pos >=17 && x_pos <= 80) 
                begin
                    cursor_y <= 0;
                end
                if(lmr[2] && y_pos >= 8 && y_pos <= 15 && x_pos >=17 && x_pos <= 80) 
                begin
                    cursor_y <= 1;
                end
                if(lmr[2] && y_pos >= 16 && y_pos <= 23 && x_pos >=17 && x_pos <= 80) 
                begin
                    cursor_y <= 2;
                end                
                if(lmr[2] && y_pos >= 24 && y_pos <= 31 && x_pos >=17 && x_pos <= 80) 
                begin
                    cursor_y <= 3;
                end                
                if(lmr[2] && y_pos >= 32 && y_pos <= 39 && x_pos >=17 && x_pos <= 80) 
                begin
                    cursor_y <= 4;
                end                
                if(lmr[2] && y_pos >= 40 && y_pos <= 47 && x_pos >=17 && x_pos <= 80) 
                begin
                    cursor_y <= 5;
                end                
                if(lmr[2] && y_pos >= 48 && y_pos <= 55 && x_pos >=17 && x_pos <= 80) 
                begin
                    cursor_y <= 6;
                end                
                if(lmr[2] && y_pos >= 56 && y_pos <= 63 && x_pos >=17 && x_pos <= 80) 
                begin
                    cursor_y <= 7;
                end                
           //____________________________________________________________________________
           end

endmodule
