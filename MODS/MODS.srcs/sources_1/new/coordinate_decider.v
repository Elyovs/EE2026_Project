`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2023 13:06:20
// Design Name: 
// Module Name: coordinate_decider
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


module coordinate_decider(
    input CLOCK, x, y,
    output reg [5:0]out_x, out_y
    );
    
    reg [5:0] chess_board [7:0][7:0];

        //parametes for the squares
    parameter square_1 = 6'b000_000;
    parameter square_2 = 6'b000_001;
    parameter square_3 = 6'b000_010;
    parameter square_4 = 6'b000_011;
    parameter square_5 = 6'b000_100;
    parameter square_6 = 6'b000_101;
    parameter square_7 = 6'b000_110;
    parameter square_8 = 6'b000_111;
    
    parameter square_9 = 6'b001_000;
    parameter square_10 = 6'b001_001;
    parameter square_11 = 6'b001_010;
    parameter square_12 = 6'b001_011;
    parameter square_13 = 6'b001_100;
    parameter square_14 = 6'b001_101;
    parameter square_15 = 6'b001_110;
    parameter square_16 = 6'b001_111;
    
    parameter square_17 = 6'b010_000;
    parameter square_18 = 6'b010_001;
    parameter square_19 = 6'b010_010;
    parameter square_20 = 6'b010_011;
    parameter square_21 = 6'b010_100;
    parameter square_22 = 6'b010_101;
    parameter square_23 = 6'b010_110;
    parameter square_24 = 6'b010_111;
    
    parameter square_25 = 6'b011_000;
    parameter square_26 = 6'b011_001;
    parameter square_27 = 6'b011_010;
    parameter square_28 = 6'b011_011;
    parameter square_29 = 6'b011_100;
    parameter square_30 = 6'b011_101;
    parameter square_31 = 6'b011_110;
    parameter square_32 = 6'b011_111;    
    
    parameter square_33 = 6'b100_000;
    parameter square_34 = 6'b100_001;
    parameter square_35 = 6'b100_010;
    parameter square_36 = 6'b100_011;
    parameter square_37 = 6'b100_100;
    parameter square_38 = 6'b100_101;
    parameter square_39 = 6'b100_110;
    parameter square_40 = 6'b100_111;
    
    parameter square_41 = 6'b101_000;
    parameter square_42 = 6'b101_001;
    parameter square_43 = 6'b101_010;
    parameter square_44 = 6'b101_011;
    parameter square_45 = 6'b101_100;
    parameter square_46 = 6'b101_101;
    parameter square_47 = 6'b101_110;
    parameter square_48 = 6'b101_111;
    
    parameter square_49 = 6'b110_000;
    parameter square_50 = 6'b110_001;
    parameter square_51 = 6'b110_010;
    parameter square_52 = 6'b110_011;
    parameter square_53 = 6'b110_100;
    parameter square_54 = 6'b110_101;
    parameter square_55 = 6'b110_110;
    parameter square_56 = 6'b110_111;
    
    parameter square_57 = 6'b111_000;
    parameter square_58 = 6'b111_001;
    parameter square_59 = 6'b111_010;
    parameter square_60 = 6'b111_011;
    parameter square_61 = 6'b111_100;
    parameter square_62 = 6'b111_101;
    parameter square_63 = 6'b111_110;
    parameter square_64 = 6'b111_111;
    
 
    //initialising each part of the 2d array of the board to the squares
    initial begin
    chess_board[0][0][5:0] = square_1;
    chess_board[0][1][5:0] = square_2;
    chess_board[0][2][5:0] = square_3;
    chess_board[0][3][5:0] = square_4;
    chess_board[0][4][5:0] = square_5;
    chess_board[0][5][5:0] = square_6;
    chess_board[0][6][5:0] = square_7;
    chess_board[0][7][5:0] = square_8;
    
    chess_board[1][0][5:0] = square_9;
    chess_board[1][1][5:0] = square_10;
    chess_board[1][2][5:0] = square_11;
    chess_board[1][3][5:0] = square_12;
    chess_board[1][4][5:0] = square_13;
    chess_board[1][5][5:0] = square_14;
    chess_board[1][6][5:0] = square_15;
    chess_board[1][7][5:0] = square_16;
    
    chess_board[2][0][5:0] = square_17;
    chess_board[2][1][5:0] = square_18;
    chess_board[2][2][5:0] = square_19;
    chess_board[2][3][5:0] = square_20;
    chess_board[2][4][5:0] = square_21;
    chess_board[2][5][5:0] = square_22;
    chess_board[2][6][5:0] = square_23;
    chess_board[2][7][5:0] = square_24;
        
    chess_board[3][0][5:0] = square_25;
    chess_board[3][1][5:0] = square_26;
    chess_board[3][2][5:0] = square_27;
    chess_board[3][3][5:0] = square_28;
    chess_board[3][4][5:0] = square_29;
    chess_board[3][5][5:0] = square_30;
    chess_board[3][6][5:0] = square_31;
    chess_board[3][7][5:0] = square_32;
        
    chess_board[4][0][5:0] = square_33;
    chess_board[4][1][5:0] = square_34;
    chess_board[4][2][5:0] = square_35;
    chess_board[4][3][5:0] = square_36;
    chess_board[4][4][5:0] = square_37;
    chess_board[4][5][5:0] = square_38;
    chess_board[4][6][5:0] = square_39;
    chess_board[4][7][5:0] = square_40;
    
    chess_board[5][0][5:0] = square_41;
    chess_board[5][1][5:0] = square_42;
    chess_board[5][2][5:0] = square_43;
    chess_board[5][3][5:0] = square_44;
    chess_board[5][4][5:0] = square_45;
    chess_board[5][5][5:0] = square_46;
    chess_board[5][6][5:0] = square_47;
    chess_board[5][7][5:0] = square_48;
    
    chess_board[6][0][5:0] = square_49;
    chess_board[6][1][5:0] = square_50;
    chess_board[6][2][5:0] = square_51;
    chess_board[6][3][5:0] = square_52;
    chess_board[6][4][5:0] = square_53;
    chess_board[6][5][5:0] = square_54;
    chess_board[6][6][5:0] = square_55;
    chess_board[6][7][5:0] = square_56;
    
    chess_board[7][0][5:0] = square_57;
    chess_board[7][1][5:0] = square_58;
    chess_board[7][2][5:0] = square_59;
    chess_board[7][3][5:0] = square_60;
    chess_board[7][4][5:0] = square_61;
    chess_board[7][5][5:0] = square_62;
    chess_board[7][6][5:0] = square_63;
    chess_board[7][7][5:0] = square_64;
    
       
    end 
    
        
    always @ (posedge CLOCK)
    begin
        if (chess_board[x][y][5:0] == square_1)
        begin
            out_x <= 16;
            out_y <= 0;
        end
        

        else if (chess_board[x][y][5:0] == square_2)
        begin
            out_x <= 24;
            out_y <= 0;
        end
        

        else if (chess_board[x][y][5:0] == square_3)
        begin
            out_x <= 32;
            out_y <= 0;
        end
        
        else if (chess_board[x][y][5:0] == square_4)
        begin
            out_x <= 40;
            out_y <= 0;
        end                
        
        else if (chess_board[x][y][5:0] == square_5)
        begin
            out_x <= 48;
            out_y <= 0;
        end        

        else if (chess_board[x][y][5:0] == square_6)
        begin
            out_x <= 56;
            out_y <= 0;
        end        
        
        else if (chess_board[x][y][5:0] == square_7)
        begin
            out_x <= 64;
            out_y <= 0;
        end
        
        else if (chess_board[x][y][5:0] == square_8)
        begin
            out_x <= 72;
            out_y <= 0;
        end
        
        else if (chess_board[x][y][5:0] == square_9)
        begin
            out_x <= 16;
            out_y <= 8;
        end        
        

        else if (chess_board[x][y][5:0] == square_10)
        begin
            out_x <= 24;
            out_y <= 8;
        end         
        
        
        else if (chess_board[x][y][5:0] == square_11)
        begin
            out_x <= 32;
            out_y <= 8;
        end         
 
 
        else if (chess_board[x][y][5:0] == square_12)
        begin
            out_x <= 40;
            out_y <= 8;
        end        


        else if (chess_board[x][y][5:0] == square_13)
        begin
            out_x <= 48;
            out_y <= 8;
        end


        else if (chess_board[x][y][5:0] == square_14)
        begin
            out_x <= 56;
            out_y <= 8;
        end 
 
 
        else if (chess_board[x][y][5:0] == square_15)
        begin
            out_x <= 64;
            out_y <= 8;
        end
 
 
        else if (chess_board[x][y][5:0] == square_16)
        begin
            out_x <= 72;
            out_y <= 8;
        end
 
        else if (chess_board[x][y][5:0] == square_17)
        begin
            out_x <= 16;
            out_y <= 16;
        end        
        

        else if (chess_board[x][y][5:0] == square_18)
        begin
            out_x <= 24;
            out_y <= 16;
        end         
        
        
        else if (chess_board[x][y][5:0] == square_19)
        begin
            out_x <= 32;
            out_y <= 16;
        end         
 
 
        else if (chess_board[x][y][5:0] == square_20)
        begin
            out_x <= 40;
            out_y <= 16;
        end        


        else if (chess_board[x][y][5:0] == square_21)
        begin
            out_x <= 48;
            out_y <= 16;
        end


        else if (chess_board[x][y][5:0] == square_22)
        begin
            out_x <= 56;
            out_y <= 16;
        end 
 
 
        else if (chess_board[x][y][5:0] == square_23)
        begin
            out_x <= 64;
            out_y <= 16;
        end
 
 
        else if (chess_board[x][y][5:0] == square_24)
        begin
            out_x <= 72;
            out_y <= 16;
        end

 
         else if (chess_board[x][y][5:0] == square_25)
        begin
            out_x <= 16;
            out_y <= 24;
        end        
        

        else if (chess_board[x][y][5:0] == square_26)
        begin
            out_x <= 24;
            out_y <= 24;
        end         
        
        
        else if (chess_board[x][y][5:0] == square_27)
        begin
            out_x <= 32;
            out_y <= 24;
        end         
 
 
        else if (chess_board[x][y][5:0] == square_28)
        begin
            out_x <= 40;
            out_y <= 24;
        end        


        else if (chess_board[x][y][5:0] == square_29)
        begin
            out_x <= 48;
            out_y <= 24;
        end


        else if (chess_board[x][y][5:0] == square_30)
        begin
            out_x <= 56;
            out_y <= 24;
        end 
 
 
        else if (chess_board[x][y][5:0] == square_31)
        begin
            out_x <= 64;
            out_y <= 24;
        end
 
 
        else if (chess_board[x][y][5:0] == square_32)
        begin
            out_x <= 72;
            out_y <= 24;
        end
        
        
        else if (chess_board[x][y][5:0] == square_33)
        begin
            out_x <= 16;
            out_y <= 32;
        end
        

        else if (chess_board[x][y][5:0] == square_34)
        begin
            out_x <= 24;
            out_y <= 32;
        end
        

        else if (chess_board[x][y][5:0] == square_35)
        begin
            out_x <= 32;
            out_y <= 32;
        end
        
        else if (chess_board[x][y][5:0] == square_36)
        begin
            out_x <= 40;
            out_y <= 32;
        end                
        
        else if (chess_board[x][y][5:0] == square_37)
        begin
            out_x <= 48;
            out_y <= 32;
        end        

        else if (chess_board[x][y][5:0] == square_38)
        begin
            out_x <= 56;
            out_y <= 32;
        end        
        
        else if (chess_board[x][y][5:0] == square_39)
        begin
            out_x <= 64;
            out_y <= 32;
        end
        
        else if (chess_board[x][y][5:0] == square_40)
        begin
            out_x <= 72;
            out_y <= 32;
        end
 
        else if (chess_board[x][y][5:0] == square_41)
        begin
            out_x <= 16;
            out_y <= 40;
        end
        

        else if (chess_board[x][y][5:0] == square_42)
        begin
            out_x <= 24;
            out_y <= 40;
        end
        

        else if (chess_board[x][y][5:0] == square_43)
        begin
            out_x <= 32;
            out_y <= 40;
        end
        
        else if (chess_board[x][y][5:0] == square_44)
        begin
            out_x <= 40;
            out_y <= 40;
        end                
        
        else if (chess_board[x][y][5:0] == square_45)
        begin
            out_x <= 48;
            out_y <= 40;
        end        

        else if (chess_board[x][y][5:0] == square_46)
        begin
            out_x <= 56;
            out_y <= 40;
        end        
        
        else if (chess_board[x][y][5:0] == square_47)
        begin
            out_x <= 64;
            out_y <= 40;
        end
        
        else if (chess_board[x][y][5:0] == square_48)
        begin
            out_x <= 72;
            out_y <= 40;
        end
 
 
        else if (chess_board[x][y][5:0] == square_49)
        begin
            out_x <= 16;
            out_y <= 48;
        end
        

        else if (chess_board[x][y][5:0] == square_50)
        begin
            out_x <= 24;
            out_y <= 48;
        end
        

        else if (chess_board[x][y][5:0] == square_51)
        begin
            out_x <= 32;
            out_y <= 48;
        end
        
        else if (chess_board[x][y][5:0] == square_52)
        begin
            out_x <= 40;
            out_y <= 48;
        end                
        
        else if (chess_board[x][y][5:0] == square_53)
        begin
            out_x <= 48;
            out_y <= 48;
        end        

        else if (chess_board[x][y][5:0] == square_54)
        begin
            out_x <= 56;
            out_y <= 48;
        end        
        
        else if (chess_board[x][y][5:0] == square_55)
        begin
            out_x <= 64;
            out_y <= 48;
        end
        
        else if (chess_board[x][y][5:0] == square_56)
        begin
            out_x <= 72;
            out_y <= 48;
        end
 
         else if (chess_board[x][y][5:0] == square_57)
        begin
            out_x <= 16;
            out_y <= 56;
        end
        

        else if (chess_board[x][y][5:0] == square_58)
        begin
            out_x <= 24;
            out_y <= 56;
        end
        

        else if (chess_board[x][y][5:0] == square_59)
        begin
            out_x <= 32;
            out_y <= 56;
        end
        
        else if (chess_board[x][y][5:0] == square_60)
        begin
            out_x <= 40;
            out_y <= 56;
        end                
        
        else if (chess_board[x][y][5:0] == square_61)
        begin
            out_x <= 48;
            out_y <= 56;
        end        

        else if (chess_board[x][y][5:0] == square_62)
        begin
            out_x <= 56;
            out_y <= 56;
        end        
        
        else if (chess_board[x][y][5:0] == square_63)
        begin
            out_x <= 64;
            out_y <= 56;
        end
        
        else if (chess_board[x][y][5:0] == square_64)
        begin
            out_x <= 72;
            out_y <= 56;
        end
 
 
 
 
 
        
        
        
     end
    
    
    
    
endmodule





module idxToCoord(input [12:0] pixel_idx, output [6:0] x, y);
    
    assign x = pixel_idx % 96;
    assign y = pixel_idx / 96;
    
endmodule
