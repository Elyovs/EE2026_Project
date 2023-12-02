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
    input clock, player, curr_player_turn,
    output reg [7:2] JA, input [7:2] JB,
    input [2:0]old_x, old_y, new_x, new_y, 
    input [3:0] state, 
    input [12:0] pix_index,
    input [63:0] avail_array,
    output reg [15:0] oled_data,
    output reg [2:0]cursor_x, cursor_y,
    inout PS2Clk, inout PS2Data,
    input [1:0] check, input moved
//    output reg [15:0] led
);

    //mouse
    wire [11:0] x_pos, y_pos;
    wire [3:0] z_pos;
    wire [2:0] lmr;
    wire n_event;
    
    reg [2:0] cur_x, cur_y;
    
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
     parameter WHITE_PIECE = 16'b00100_110110_11101;    // it's blue
     
     parameter BLACK_SQ = 16'b10010_010011_00010;       //it's brown
     parameter WHITE_SQ = 16'b11111_111111_11111;       //it's white
     parameter AVAIL_SQ = 16'b11110_111111_00010;        //it becomes yellow when it's available
     
     parameter BLACK_CURSOR = 16'b00000_000000_00000;
     parameter LIGHT_PINK = 16'b11011_011101_10001;
     
     parameter ORANGE = 16'hfa60;
     
    
     reg [3:0] chess_board[63:0];

     wire [12:0] x, y;
     idxToCoord idxToCoord_unit (pix_index, x, y);
    

    wire [12:0] x_coord, y_coord;    
      reg[8:0]old_b, new_b; 

     
     //setting up the array
      initial begin
      old_b <= 35;
      new_b <= 35;      
      
      
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
       

      
      reg [6:0]c = 0;   
      reg [63:0] bool_available = 0;     
      reg bool_move_new = 0;
      wire [3:0] fixed_state;
      assign fixed_state[3] = ~state[3];
      assign fixed_state[2:0] = state[2:0];
      
      //updating the new square
      always @ (posedge clock)
      begin
        if (moved) begin
            old_b = ((old_y * 8) + old_x);
            chess_board[old_b] = {BLACK, EMPTY};
            new_b = ((new_y * 8) + new_x);
            bool_move_new = 1;
        end
        if (bool_move_new) begin
            chess_board[new_b] = {fixed_state};
            bool_move_new = 0;
        end

        for (c = 0; c < 64; c = c + 1)
        begin
            if (avail_array[c] == 1)
            begin
                bool_available[c] <= 1;
            end
            else if (avail_array[c] == 0)
            begin
                bool_available[c] <= 0;
            end
         end
      end
       
       reg [31:0] count_x = 0;
       reg [31:0] count_y = 0;
       reg [31:0] b;
       
       assign x_coord = (count_x * 8) + 16;
       assign y_coord = (count_y * 8);
      
       
       wire [31:0] player_turn_screen_x = 38;   //large mid
       wire [31:0] player_turn_screen_y = 19;   //large mid
       wire [31:0] player_turn = 3; //small edge
       
       wire [31:0] check_x = 87;
       wire [31:0] check_y = 44;
       
       parameter P1_COLOR = 16'hf800;
       parameter P2_COLOR = 16'h2bf;
       parameter BORDER_COLOR = 16'b0;
       parameter SHAPE_BACKGROUND = 16'hffff;
       
       
       //drawing the pieces
       always @ (posedge clock)
       begin

           count_y <= (count_y >= 7) ? 0 : count_y + 1;
            
           if (count_y == 0)
           begin
               count_x <= (count_x >= 7) ? 0 : count_x + 1;
           end
           
           //board visual for player 1 and 2 - rotation
           if (player == 0) //player 1
           begin
                b <= (((count_y + 1) * 8) + count_x);
           end
           else b <= 63 - (((count_y + 1) * 8) + count_x);  //player 2
           
           
           
           
           //mouse cursor
            if (((x >= x_pos - 1 && x <= x_pos + 1) && y == y_pos) || 
                (x == x_pos && (y >= y_pos - 1 && y <= y_pos + 1)))
            begin
                oled_data <= LIGHT_PINK;
            end
            
            else if ((x == x_pos - 1 && (y == y_pos - 1 || y == y_pos + 1)) ||
                (x == x_pos + 1 && (y == y_pos - 1 || y == y_pos + 1)))
            begin
                oled_data <= BLACK_CURSOR;
            end
            
            //P1 - small edge
            else if (curr_player_turn == 0 && ((x >= player_turn && x <= (player_turn + 2) && y >= player_turn && y <= (player_turn + 4)) || 
                (x >= (player_turn + 3) && x <= (player_turn + 9) && y >= player_turn && y <= (player_turn + 21))))
            begin
                oled_data <= P1_COLOR;
            end
            
            //P2 - small edge
            else if (curr_player_turn == 1 && ((x >= player_turn && x <= (player_turn + 9) && y >= player_turn && y <= (player_turn + 4)) ||
                (x >= player_turn && x <= (player_turn + 9) && y >= (player_turn + 9) && y <= (player_turn + 12)) ||
                (x >= player_turn && x <= (player_turn + 9) && y >= (player_turn + 17) && y <= (player_turn + 21)) ||
                (x >= (player_turn + 5) && x <= (player_turn + 9) && y >= player_turn && y <= (player_turn + 12)) ||
                (x >= player_turn && x <= (player_turn + 4) && y >= (player_turn + 9) && y <= (player_turn + 21))))
            begin
                oled_data <= P2_COLOR;
            end
       
           
          else if (chess_board[b] == {BLACK, PAWN} && 
              (((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) || 
              ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
              ((y == y_coord + 3) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
              ((y >= y_coord + 4 && y <= y_coord + 6) && (x == x_coord + 3 || x == x_coord + 4)) ||
              ((y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6))) )
              begin
                 if (bool_available[b] == 1)
                 begin
                      oled_data <= AVAIL_SQ;
                  end
                  else begin
                      oled_data <= BLACK_PIECE; 
                   end
              end
           
          else if (chess_board[b] == {WHITE, PAWN} && 
              (((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) || 
              ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
              ((y == y_coord + 3) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
              ((y >= y_coord + 4 && y <= y_coord + 6) && (x == x_coord + 3 || x == x_coord + 4)) ||
              ((y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6))) )
              begin
                  if (bool_available[b] == 1)
                  begin
                       oled_data <= AVAIL_SQ;
                  end
                  else begin
                      oled_data <= WHITE_PIECE; 
                  end
               end
                         
           
           
           else if (chess_board[b] == {BLACK, ROOK} &&
           ( ((y == y_coord + 1) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
           ((y == y_coord + 2 || y == y_coord + 3 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
           ((y == y_coord + 4 || y == y_coord + 5) && (x == x_coord + 3 || x == x_coord + 4)) ||
           ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
            begin
              if (bool_available[b] == 1)
              begin
                   oled_data <= AVAIL_SQ;
               end
               else begin
                   oled_data <= BLACK_PIECE; 
                end
           end
            
            
           else if (chess_board[b] == {WHITE, ROOK} &&
            ( ((y == y_coord + 1) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
            ((y == y_coord + 2 || y == y_coord + 3 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
            ((y == y_coord + 4 || y == y_coord + 5) && (x == x_coord + 3 || x == x_coord + 4)) ||
            ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
             begin
                if (bool_available[b] == 1)
                begin
                     oled_data <= AVAIL_SQ;
                end
                else begin
                    oled_data <= WHITE_PIECE; 
                end
             end
              
           
            else if (chess_board[b] == {BLACK, BISHOP} &&
                     ( ((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) ||
                     ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
                     ((y == y_coord + 3) && ((x >= x_coord + 1 && x <= x_coord + 4) || x == x_coord + 6)) ||
                     ((y == y_coord + 4) && ((x >= x_coord + 1 && x <= x_coord + 3) || x == x_coord + 5 || x == x_coord + 6)) ||
                     ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                     ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                    begin
                        if (bool_available[b] == 1)
                        begin
                             oled_data <= AVAIL_SQ;
                         end
                         else begin
                             oled_data <= BLACK_PIECE; 
                          end
                     end
           
            else if (chess_board[b] == {WHITE, BISHOP} &&
                      ( ((y == y_coord + 1) && (x == x_coord + 3 || x == x_coord + 4)) ||
                      ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
                      ((y == y_coord + 3) && ((x >= x_coord + 1 && x <= x_coord + 4) || x == x_coord + 6)) ||
                      ((y == y_coord + 4) && ((x >= x_coord + 1 && x <= x_coord + 3) || x == x_coord + 5 || x == x_coord + 6)) ||
                      ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                      ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                     begin
                          if (bool_available[b] == 1)
                          begin
                               oled_data <= AVAIL_SQ;
                          end
                          else begin
                              oled_data <= WHITE_PIECE; 
                          end
                       end
                                   
           
           
          else if (chess_board[b] == {BLACK, KNIGHT} &&
                    ( ((y == y_coord + 1) && (x == x_coord + 3)) ||
                     ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
                    ((y == y_coord + 3) && (x == x_coord + 1 || (x >= x_coord + 3 && x <= x_coord + 6))) ||
                    ((y == y_coord + 4 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                    ((y == y_coord + 5) && (x == x_coord + 1 || (x >= x_coord + 4 && x <= x_coord + 6))) ||
                    ((y == y_coord + 6) && (x >= x_coord + 3 && x <= x_coord + 5)) ))
                    begin
                       if (bool_available[b] == 1)
                       begin
                            oled_data <= AVAIL_SQ;
                        end
                        else begin
                            oled_data <= BLACK_PIECE; 
                         end
                    end    
           
          else if (chess_board[b] == {WHITE, KNIGHT} &&
                  ( ((y == y_coord + 1) && (x == x_coord + 3)) ||
                   ((y == y_coord + 2) && (x >= x_coord + 2 && x <= x_coord + 5)) ||
                  ((y == y_coord + 3) && (x == x_coord + 1 || (x >= x_coord + 3 && x <= x_coord + 6))) ||
                  ((y == y_coord + 4 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                  ((y == y_coord + 5) && (x == x_coord + 1 || (x >= x_coord + 4 && x <= x_coord + 6))) ||
                  ((y == y_coord + 6) && (x >= x_coord + 3 && x <= x_coord + 5)) ))
                     begin
                      if (bool_available[b] == 1)
                      begin
                           oled_data <= AVAIL_SQ;
                      end
                      else begin
                          oled_data <= WHITE_PIECE; 
                      end
                   end
                                    
           
           
              else if (chess_board[b] == {BLACK, QUEEN} &&
                      (((y == y_coord + 1 || y == y_coord + 6) && (x == x_coord + 3 || x == x_coord + 4)) ||
                      ((y == y_coord + 2 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                      ((y == y_coord + 3 || y == y_coord + 4) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
                      ((y == y_coord + 5) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                       begin
                         if (bool_available[b] == 1)
                         begin
                              oled_data <= AVAIL_SQ;
                          end
                          else begin
                              oled_data <= BLACK_PIECE; 
                           end
                       end                           
            
           
              else if (chess_board[b] == {WHITE, QUEEN} &&
                        (((y == y_coord + 1 || y == y_coord + 6) && (x == x_coord + 3 || x == x_coord + 4)) ||
                        ((y == y_coord + 2 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                        ((y == y_coord + 3 || y == y_coord + 4) && (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
                        ((y == y_coord + 5) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                         begin
                            if (bool_available[b] == 1)
                            begin
                                 oled_data <= AVAIL_SQ;
                            end
                            else begin
                                oled_data <= WHITE_PIECE; 
                            end
                         end
                                    
           
           
              else if (chess_board[b] == {BLACK, KING} &&
                       ( ((y == y_coord + 1 || y == y_coord + 3 || y == y_coord + 4) &&
                       (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
                       ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                       ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                        begin
                          if (bool_available[b] == 1)
                          begin
                               oled_data <= AVAIL_SQ;
                           end
                           else begin
                               oled_data <= BLACK_PIECE; 
                            end
                       end          
 
              else if (chess_board[b] == {WHITE, KING} &&
                     ( ((y == y_coord + 1 || y == y_coord + 3 || y == y_coord + 4) &&
                     (x == x_coord + 1 || x == x_coord + 3 || x == x_coord + 4 || x == x_coord + 6)) ||
                     ((y == y_coord + 5 || y == y_coord + 7) && (x >= x_coord + 1 && x <= x_coord + 6)) ||
                     ((y == y_coord + 6) && (x >= x_coord + 2 && x <= x_coord + 5)) ))
                     begin
                         if (bool_available[b] == 1)
                         begin
                              oled_data <= AVAIL_SQ;
                         end
                         else begin
                             oled_data <= WHITE_PIECE; 
                         end
                      end
                       
                      
                                 
            else if ((chess_board[b] == {BLACK, EMPTY}) && (bool_available[b] == 1) &&
                    (x >= x_coord && x < x_coord + 8 && y >= y_coord && y < y_coord + 8)) //if it's available, become yellow
                    begin
                        oled_data <= AVAIL_SQ;
                    end  
                
           //check
           else if (check[0] && player == 0 && 
                   (((x == check_x || x == (check_x + 4)) && y >= (check_y + 1) && y <= (check_y + 7)) ||
                   (x >= (check_x + 1) && x <= (check_x + 3) && y >= check_y && y <= (check_y + 9)) ||
                   (x == (check_x + 2) && y == (check_y + 10)) || 
                   (x >= (check_x + 1) && x <= (check_x + 3) && y >= (check_y + 12) && y <= (check_y + 14))))
           begin
                oled_data <= ORANGE;
           end
           
           else if (check[1] && player == 1 && 
                   (((x == check_x || x == (check_x + 4)) && y >= (check_y + 1) && y <= (check_y + 7)) ||
                   (x >= (check_x + 1) && x <= (check_x + 3) && y >= check_y && y <= (check_y + 9)) ||
                   (x == (check_x + 2) && y == (check_y + 10)) || 
                   (x >= (check_x + 1) && x <= (check_x + 3) && y >= (check_y + 12) && y <= (check_y + 14))))
           begin
                oled_data <= ORANGE;
           end
           
             else if (x < 16 || x >= 80)
                      begin
                        oled_data <= BLACK_PIECE;   //black screen not on chessboard
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
           
           if (curr_player_turn != player)
           begin
                cursor_x <= JB[7:5];
                cursor_y <= JB[4:2];
           end
           
           if(player == curr_player_turn && lmr[2] && x_pos >= 17 && x_pos <= 24 && y_pos >= 0 && y_pos <= 63) 
           begin
               cur_x <= (player == 0) ? 0 : 7;
               if (player == curr_player_turn)
               begin
                   cursor_x <= cur_x;
                   JA[7:5] <= cur_x;
               end
//               else cursor_x <= JB[7:5];
           end
           
           if(player == curr_player_turn && lmr[2] && x_pos >= 25 && x_pos <= 32 && y_pos >= 0 && y_pos <= 63) 
           begin
               cur_x <= (player == 0) ? 1 : 6;
               if (player == curr_player_turn)
               begin
                   cursor_x <= cur_x;
                   JA[7:5] <= cur_x;
               end
//               else cursor_x <= JB[7:5];
           end
           if(player == curr_player_turn && lmr[2] && x_pos >= 33 && x_pos <= 40 && y_pos >= 0 && y_pos <= 63) 
           begin
               cur_x <= (player == 0) ? 2 : 5;
               if (player == curr_player_turn)
               begin
                   cursor_x <= cur_x;
                   JA[7:5] <= cur_x;
               end
//               else cursor_x <= JB[7:5];                    
           end
           if(player == curr_player_turn && lmr[2] && x_pos >= 41 && x_pos <= 48 && y_pos >= 0 && y_pos <= 63)
           begin
               cur_x <= (player == 0) ? 3 : 4;
               if (player == curr_player_turn)
               begin
                   cursor_x <= cur_x;
                   JA[7:5] <= cur_x;
               end
//               else cursor_x <= JB[7:5];                    
           end
           if(player == curr_player_turn && lmr[2] && x_pos >= 49 && x_pos <= 56 && y_pos >= 0 && y_pos <= 63)
           begin
               cur_x <= (player == 0) ? 4 : 3;
               if (player == curr_player_turn)
               begin
                   cursor_x <= cur_x;
                   JA[7:5] <= cur_x;
               end
//               else cursor_x <= JB[7:5];                    
           end
           if(player == curr_player_turn && lmr[2] && x_pos >= 57 && x_pos <= 64 && y_pos >= 0 && y_pos <= 63) 
           begin
               cur_x <= (player == 0) ? 5 : 2;
               if (player == curr_player_turn)
               begin
                   cursor_x <= cur_x;
                   JA[7:5] <= cur_x;
               end
//               else cursor_x <= JB[7:5];                    
           end
           if(player == curr_player_turn && lmr[2] && x_pos >= 65 && x_pos <= 72 && y_pos >= 0 && y_pos <= 63)
           begin
               cur_x <= (player == 0) ? 6 : 1;
               if (player == curr_player_turn)
               begin
                   cursor_x <= cur_x;
                   JA[7:5] <= cur_x;
               end
//               else cursor_x <= JB[7:5];                    
           end
           if(player == curr_player_turn && lmr[2] && x_pos >= 73 && x_pos <= 80 && y_pos >= 0 && y_pos <= 63) 
           begin
               cur_x <= (player == 0) ? 7 : 0;
               if (player == curr_player_turn)
               begin
                   cursor_x <= cur_x;
                   JA[7:5] <= cur_x;
               end
//               else cursor_x <= JB[7:5];                    
           end
           
           if(player == curr_player_turn && lmr[2] && y_pos >= 0 && y_pos <= 7 && x_pos >=17 && x_pos <= 80) 
           begin
               cur_y <= (player == 0) ? 0 : 7;
               if (player == curr_player_turn)
               begin
                   cursor_y <= cur_y;
                   JA[4:2] <= cur_y;
               end
//               else cursor_x <= JB[4:2];                    
           end
           if(player == curr_player_turn && lmr[2] && y_pos >= 8 && y_pos <= 15 && x_pos >=17 && x_pos <= 80) 
           begin
               cur_y <= (player == 0) ? 1 : 6;
               if (player == curr_player_turn)
               begin
                   cursor_y <= cur_y;
                   JA[4:2] <= cur_y;
               end
//               else cursor_x <= JB[4:2];                        
           end
           if(player == curr_player_turn && lmr[2] && y_pos >= 16 && y_pos <= 23 && x_pos >=17 && x_pos <= 80) 
           begin
               cur_y <= (player == 0) ? 2 : 5;
               if (player == curr_player_turn)
               begin
                   cursor_y <= cur_y;
                   JA[4:2] <= cur_y;
               end
//               else cursor_x <= JB[4:2];                        
           end                
           if(player == curr_player_turn && lmr[2] && y_pos >= 24 && y_pos <= 31 && x_pos >=17 && x_pos <= 80) 
           begin
               cur_y <= (player == 0) ? 3 : 4;
               if (player == curr_player_turn)
               begin
                   cursor_y <= cur_y;
                   JA[4:2] <= cur_y;
               end
//               else cursor_x <= JB[4:2];                        
           end                
           if(player == curr_player_turn && lmr[2] && y_pos >= 32 && y_pos <= 39 && x_pos >=17 && x_pos <= 80) 
           begin
               cur_y <= (player == 0) ? 4 : 3;
               if (player == curr_player_turn)
               begin
                   cursor_y <= cur_y;
                   JA[4:2] <= cur_y;
               end
//               else cursor_x <= JB[4:2];                        
           end                
           if(player == curr_player_turn && lmr[2] && y_pos >= 40 && y_pos <= 47 && x_pos >=17 && x_pos <= 80) 
           begin
               cur_y <= (player == 0) ? 5 : 2;
               if (player == curr_player_turn)
               begin
                   cursor_y <= cur_y;
                   JA[4:2] <= cur_y;
               end
//               else cursor_x <= JB[4:2];                        
           end                
           if(player == curr_player_turn && lmr[2] && y_pos >= 48 && y_pos <= 55 && x_pos >=17 && x_pos <= 80) 
           begin
               cur_y <= (player == 0) ? 6 : 1;
               if (player == curr_player_turn)
               begin
                   cursor_y <= cur_y;
                   JA[4:2] <= cur_y;
               end
//               else cursor_x <= JB[4:2];                        
           end                
           if(player == curr_player_turn && lmr[2] && y_pos >= 56 && y_pos <= 63 && x_pos >=17 && x_pos <= 80) 
           begin
               cur_y <= (player == 0) ? 7 : 0;
               if (player == curr_player_turn)
               begin
                   cursor_y <= cur_y;
                   JA[4:2] <= cur_y;
               end
//               else cursor_x <= JB[4:2];                        
           end          
           end

endmodule
           
        