//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 25.10.2023 17:38:46
//// Design Name: 
//// Module Name: menu
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////

////start code: 206 (to start playing, confirming ready to play)
////start code need to be inputted in order 2 -> 0 -> 6
////led will light up if correct and code shown in seven segment

////2 second after correct code inputted, seven segment will change
////and show what player it is (player 1 or 2)

////sw15 to switch between player 1 and player 2
////sw15 == 0 player 1, sw15 == 1 player 2

////JB[0] -> JA[0] PLAYER : 0 - player 1, 1 - player 2
////JB[1] -> JA[1] START BOOL : 0 - not ready/start, 1 - ready/start

//module menu(
//    input clock, input [15:0] sw, input btnC, input [1:0] JB,
//    output [7:0] JC, output reg [6:0] seg, output reg [15:0] led, 
//    output reg [3:0] an, output reg dp, output reg [1:0] JA,
//    input [12:0] pix_index, output reg [15:0] oled_data,
//    output reg start, player
//);
//    initial
//    begin
//        seg <= 7'b1111111;
//        led <= 16'b0000000000000000;
//        an <= 4'b1111;
//        dp <= 1'b1;
//        start <= 0;
//        player <= 0;
//        JA[1] <= 0;
//    end
    
//    // OLED Display
//    wire [31:0] count_6p25 = 7;
//    wire clk_6p25;
//    flexible_clock clk6p25m (.basys_clk(clock), .count_in(count_6p25), .out_clk(clk_6p25));
    
////    wire frame_beg, send_pix, sample_pix;
////    reg [15:0] oled_data;
////    wire [12:0] pix_index;
    

////    Oled_Display unit_oled_A (
////            .clk(clk_6p25), 
////            .reset(0), 
////            .frame_begin(frame_beg), 
////            .sending_pixels(send_pix),
////            .sample_pixel(sample_pix), 
////            .pixel_index(pix_index), 
////            .pixel_data(oled_data), 
////            .cs(JC[0]), 
////            .sdin(JC[1]), 
////            .sclk(JC[3]), 
////            .d_cn(JC[4]), 
////            .resn(JC[5]), 
////            .vccen(JC[6]),
////            .pmoden(JC[7])
////        );
    
//    //SEVEN SEGMENT CLOCK
//    wire [31:0] count_0p005s = 249_999;
//    wire clk_0p005s;
//    flexible_clock clk0p005s (.basys_clk(clock), .count_in(count_0p005s), .out_clk(clk_0p005s));
    
//    reg [31:0] count_seg = 0;
//    reg [31:0] count_pass = 0;
        
//    //COLOR PARAMETER
//    parameter BROWN = 16'b00110_001100_00011;
//    parameter LIGHT_BLUE = 16'b01111_110111_10111;
//    parameter WHITE = 16'b11111_111111_11111;
//    parameter LIGHT_RED = 16'b11011_011010_01110;
//    parameter YELLOW = 16'b11111_110110_00101;
//    parameter ORANGE = 16'b11111_101101_01101;
//    parameter BLUE = 16'b01001_100111_11100;
    
//    wire [12:0] x, y;
//    idxToCoord idxToCoord_unit (pix_index, x, y);
    
//    wire [12:0] S_a = 32;
//    wire [12:0] S_b = 40;
    
//    wire [12:0] T_a = 39;
//    wire [12:0] T_b = 40;
    
//    wire [12:0] A_a = 46;
//    wire [12:0] A_b = 40;
    
//    wire [12:0] R_a = 53;
//    wire [12:0] R_b = 40;
    
//    wire [12:0] T2_a = 60;
//    wire [12:0] T2_b = 40;
    
//    wire [12:0] N2_a = 37;
//    wire [12:0] N2_b = 47;
    
//    wire [12:0] N0_a = 45;
//    wire [12:0] N0_b = 47;
    
//    wire [12:0] N6_a = 53;
//    wire [12:0] N6_b = 47;
    
//    wire [12:0] arr_a = 27;
//    wire [12:0] arr_b = 49;
    
//    wire [12:0] S2_a = 18;
//    wire [12:0] S2_b = 49;
    
//    wire [12:0] W_a = 22;
//    wire [12:0] W_b = 49;
    
//    wire [12:0] t_a = 35;
//    wire [12:0] i_a = 43;
//    wire [12:0] m_a = 47;
//    wire [12:0] e_a = 55;
//    wire [12:0] time_b = 26;
    
//    reg [2:0] toggle_2s = 0;
//    reg [31:0] count_2s = 0;
    
//    reg [31:0] count_seg_2 = 0;
    
//    reg [2:0] toggle_code = 0;
//    reg [31:0] count_0p5s = 0;
    
//    always @ (posedge clk_6p25)
//    begin
//        //C
//        if((x > 14 && x < 21 && y > 7 && y < 10) ||
//           (x > 20 && x < 23 && y > 9 && y < 13) ||
//           (x > 13 && x < 17 && y > 9 && y < 12) ||
//           (x > 11 && x < 14 && y > 10 && y < 20) ||
//           (x > 13 && x < 17 && y > 18 && y < 21) ||
//           (x > 14 && x < 21 && y > 20 && y < 23) ||
//           (x > 20 && x < 23 && y > 18 && y < 21))   
//        begin
//            oled_data <= LIGHT_BLUE;
//        end
        
//        //H
//        else if((x > 27 && x < 30 && y > 7 && y < 23) ||
//                (x > 37 && x < 40 && y > 7 && y < 23) ||
//                (x >= 30 && x < 37 && y > 12 && y < 15))
//        begin
//            oled_data <= LIGHT_BLUE;
//        end
        
//        //E
//        else if((x > 42 && x < 45 && y > 7 && y < 23) ||
//                (x > 42 && x < 53 && y > 7 && y < 10) ||
//                (x > 42 && x < 53 && y > 20 && y < 23) ||
//                (x > 46 && x < 51 && y > 13 && y < 16))
//        begin
//            oled_data <= LIGHT_BLUE;
//        end
        
//        //S
//        else if ((x > 58 && x < 66 && y > 7 && y < 10) ||
//                (x > 64 && x < 67 && y > 8 && y < 12) ||
//                (x > 57 && x < 60 && y > 8 && y < 12) ||
//                (x > 56 && x < 59 && y > 10 && y < 14) ||
//                (x > 57 && x < 64 && y > 13 && y < 16) ||
//                (x > 61 && x < 66 && y > 14 && y < 17) ||
//                (x > 64 && x < 67 && y > 16 && y < 22) ||
//                (x > 59 && x < 65 && y > 20 && y < 23) ||
//                (x > 57 && x < 60 && y > 18 && y < 22))
//        begin
//            oled_data <= LIGHT_BLUE;
//        end 
        
//        //S
//        else if ((x > 72 && x < 80 && y > 7 && y < 10) ||
//                (x > 78 && x < 81 && y > 8 && y < 12) ||
//                (x > 71 && x < 74 && y > 8 && y < 12) ||
//                (x > 70 && x < 73 && y > 10 && y < 14) ||
//                (x > 71 && x < 78 && y > 13 && y < 16) ||
//                (x > 75 && x < 80 && y > 14 && y < 17) ||
//                (x > 78 && x < 81 && y > 16 && y < 22) ||
//                (x > 73 && x < 79 && y > 20 && y < 23) ||
//                (x > 71 && x < 74 && y > 18 && y < 22))
//        begin
//            oled_data <= LIGHT_BLUE;
//        end 
        
//        //T
//        else if ((x >= t_a && x <= (t_a + 5) && y >= time_b && y <= (time_b + 1)) ||
//            (x >= (t_a + 2) && x <= (t_a + 3) && y >= time_b && y <= (time_b + 6)))
//        begin
//            oled_data <= BLUE;
//        end
        
//        //I
//        else if (x >= i_a && x <= (i_a + 1) && y >= time_b && y <= (time_b + 6))
//        begin
//            oled_data <= BLUE;
//        end
        
//        //M
//        else if (((x == m_a || x == (m_a + 6)) && y == time_b) || (x >= m_a && x <= (m_a + 1) && y >= (time_b + 1) && y <= (time_b + 6)) ||
//            (x >= (m_a + 5) && x <= (m_a + 6) && y >= (time_b + 1) && y <= (time_b + 6)) ||
//            (x == (m_a + 2) && y >= (time_b + 1) && y <= (time_b + 2)) ||
//            (x == (m_a + 3) && y >= (time_b + 2) && y <= (time_b + 3)) ||
//            (x == (m_a + 4) && y >= (time_b + 1) && y <= (time_b + 2)))
//        begin
//            oled_data <= BLUE;
//        end
        
//        //E
//        else if ((x >= e_a && x <= (e_a + 1) && y >= time_b && y <= (time_b + 6)) ||
//            (x >= e_a && x <= (e_a + 4) && (y == time_b || y == (time_b + 1) || y == (time_b + 3) || y == (time_b + 5) || y == (time_b + 6))))
//        begin
//            oled_data <= BLUE;
//        end
        
//        //S
//        else if ((x >= (S_a + 1) && x <= (S_a + 2) && y == S_b) || (x == S_a && y == (S_b + 1)) ||
//            (x == (S_a + 1) && y == (S_b + 2)) || (x == (S_a + 2) && y == (S_b + 3)) ||
//            (x >= S_a && x <= (S_a + 1) && y == (S_b + 4)))
//        begin
//            oled_data <= WHITE;
//        end
        
//        //T
//        else if ((x >= T_a && x <= (T_a + 2) && y == T_b) || (x == (T_a + 1) && y >= T_b && y <= (T_b + 4)))
//        begin
//            oled_data <= WHITE;
//        end

//        //A
//        else if((x == (A_a + 1) && y == A_b) || (x == A_a && y > A_b && y <= (A_b + 4)) ||
//            (x == (A_a + 2) && y > A_b && y <= A_b + 4) || (x == (A_a + 1) && y == (A_b + 2)))
//        begin
//            oled_data <= WHITE;
//        end
        
//        //R
//        else if ((x == R_a && y >= R_b && y <= (R_b + 4)) || (x >= R_a && x <= (R_a + 2) && y == R_b) ||
//            (x == (R_a + 2) && y >= R_b && y <= (R_b + 2)) || (x >= R_a && x <= (R_a + 2) && y == (R_b + 2)) ||
//            (x == (R_a + 1) && y == (R_b + 3)) || (x == (R_a + 2) && y == (R_b + 4)))
//        begin
//            oled_data <= WHITE;
//        end
        
//        //T
//        else if ((x >= T2_a && x <= (T2_a + 2) && y == T2_b) || (x == (T2_a + 1) && y >= T2_b && y <= (T2_b + 4)))
//        begin
//            oled_data <= WHITE;
//        end
        
//        //s
//        else if ((x >= (S2_a + 1) && x <= (S2_a + 2) && y == S2_b) || (x == S2_a && y == (S2_b + 1)) ||
//            (x == (S2_a + 1) && y == (S2_b + 2)) || (x == (S2_a + 2) && y == (S2_b + 3)) ||
//            (x >= S2_a && x <= (S2_a + 1) && y == (S2_b + 4)))
//        begin
//            oled_data <= ORANGE;
//        end
        
//        //w
//        else if (((x == W_a || x == (W_a + 2)) && y >= W_b && y <= (W_b + 4)) || (x == (W_a + 1) && y == (W_b + 3))) 
//        begin
//            oled_data <= ORANGE;
//        end
        
//        //Arrow
//        else if ((x >= arr_a && x <= (arr_a + 6) && y == (arr_b + 2)) ||
//        (x == (arr_a + 4) && y >= arr_b && y <= (arr_a + 4)) ||
//        (x == (arr_a + 5) && y >= (arr_b + 1) && y <= (arr_b + 3)))
//        begin
//            oled_data <= YELLOW;
//        end
        
//        //2
//        else if (toggle_code && ((x >= N2_a && x <= (N2_a + 5) && (y == N2_b || y == (N2_b + 1) || 
//            y == (N2_b + 4) || y == (N2_b + 5) || y == (N2_b + 7) || y == (N2_b + 8))) ||
//            (x >= (N2_a + 4) && x <= (N2_a + 5) && y >= (N2_b + 2) && y <= (N2_b + 3)) ||
//            (x >= N2_a && x <= (N2_a + 1) && y == (N2_b + 6))))
//        begin
//            oled_data <= LIGHT_RED;
//        end
        
//        //0
//        else if (toggle_code && ((x >= N0_a && x <= (N0_a + 5) && (y == N0_b || y == (N0_b + 1) || y == (N0_b + 7) || y == (N0_b + 8))) ||
//            ((x == N0_a || x == (N0_a + 1) || x == (N0_a + 4) || x == (N0_a + 5)) &&
//            y >= N0_b && y <= (N0_b + 8))))
//        begin
//            oled_data <= LIGHT_RED;
//        end
        
//        //6
//        else if (toggle_code && ((x >= N6_a && x <= (N6_a + 5) && (y == N6_b || y == (N6_b + 1) || y == (N6_b + 3) ||
//            y == (N6_b + 4) || y == (N6_b + 7) || y == (N6_b + 8))) || (x >= N6_a && x <= (N6_a + 1) && 
//           y >= N6_b && y <= (N6_b + 8)) || (x >= (N6_a + 4) && x <= (N6_a + 5) && y >= (N6_b + 3) && y <= (N6_b + 8))))
//        begin
//            oled_data <= LIGHT_RED;
//        end
        
//        else oled_data <= BROWN;

//    end
    
//    always @ (posedge clk_6p25)
//    begin
    
//        //PLAYER
//        player <= (start == 0) ? sw[15] : player;
//        JA[0] <= player;
        
//        //only player 1 can start the game
//        //if btnC is presed && player 1 && other board player 2
//        if (btnC && player == 0 && JB[0] == 1 && count_pass == 3)
//        begin
//            start <= 1;
//            JA[1] <= 1;
//        end
//        led[8] <= JB[0];
//        led[9] <= JB[1];
//        led[10] <= JA[1];
//        //change start status for player 2
//        //if player 2 && start == 1 && the other board player 1
//        if (player == 1 && JB[1] == 1 && JB[0] == 0)
//        begin
//            start <= 1;
//        end
        
//        //START CODE: 206
//        if (sw[14:0] == 15'b000000000000100 && count_pass == 0)
//        begin
//            count_pass <= 1;
//            JA[1] <= 0;
//        end
        
//        if (sw[14:0] == 15'b000000000000101 && count_pass == 1)
//        begin
//            count_pass <= 2;
//            JA[1] <= 0;
//        end
        
//        if(sw[14:0] == 15'b000000001000101 && count_pass == 2)
//        begin
//            count_pass <= 3;
//            JA[1] <= 0;
//        end
            
//        if (count_pass == 0) led[14:0] <= 16'b0000000000000000; 
//        if (count_pass == 1) led[2] <= 1'b1;
//        if (count_pass == 2) led[2:0] <= 3'b101;
//        if (count_pass == 3) 
//        begin
//            led[6:0] <= 7'b1000101;
//            toggle_2s <= 1;
//        end

        
//        if (count_seg == 1 && count_2s < 400)
//        begin
//            seg <= 7'b0100100;
//            an <= 4'b0111;
//        end
        
//        if(count_seg == 2 && count_2s < 400)
//        begin
//            seg <= 7'b1000000;
//            an <= 4'b1011;
//        end
        
//        if(count_seg == 3 && count_2s < 400)
//        begin
//            seg <= 7'b0000010;
//            an <= 4'b1101;
//        end
        
//        if(count_2s >= 400 && count_seg_2 == 1)
//        begin
//            seg <= 7'b0001100;
//            an <= 4'b0111;
//        end
//        if(count_2s >= 400 && count_seg_2 == 2 && player == 0)
//        begin
//            seg <= 7'b1111001;
//            an <= 4'b1011;
//        end
//        if(count_2s >= 400 && count_seg_2 == 2 && player == 1)
//        begin
//            seg <= 7'b0100100;
//            an <= 4'b1011;
//        end


//    end
    
//    always @ (posedge clk_0p005s)
//    begin
//        count_seg <= (count_seg >= count_pass) ? 0 : count_seg + 1;
        
//        if (toggle_2s)
//        begin
//            count_2s <= (count_2s >= 400) ? count_2s : count_2s + 1;
//        end
        
//        if (count_2s >= 400)
//        begin
//            count_seg_2 <= (count_seg_2 >= 3) ? 0 : count_seg_2 + 1;
//        end
        
//        count_0p5s <= (count_0p5s >= 100) ? 0 : count_0p5s + 1;
        
//        if (count_0p5s >= 100)
//        begin
//            toggle_code <= (toggle_code) ? 0 : 1;
//        end
        
//    end

//endmodule