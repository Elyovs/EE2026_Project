`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 01:35:31
// Design Name: 
// Module Name: end_game
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


module end_game(
    input clock, winner, input [12:0] pix_index,
    output reg [15:0] oled_data
    );
    
    wire [12:0] x, y;
    idxToCoord idxToCoord_unit (pix_index, x, y);
    
    wire [31:0] count_0p5s = 24_999;
    wire clk_0p5s;
    flexible_clock clk0p5s (clock, count_0p5s, clk_0p5s);    
    
    wire [31:0] p_x = 39;
    wire [31:0] p_y = 10;
    wire [31:0] p1_2_x = 52;
    
    wire [31:0] w_x = 33;
    wire [31:0] i_x = 48;
    wire [31:0] n_x = 54;
    wire [31:0] win_y = 27;
    
    wire [31:0] g_x = 16;
    wire [31:0] a_x = 24;
    wire [31:0] m_x = 32;
    wire [31:0] e_x = 42;
    wire [31:0] o_x = 52;
    wire [31:0] v_x = 60;
    wire [31:0] e2_x = 68;
    wire [31:0] r_x = 75;
    wire [31:0] end_y = 49;
    
    reg [31:0] s1_x = 4;
    reg [31:0] s1_y = 5;
    reg [31:0] s2_x = 64;
    reg [31:0] s2_y = 35;
    reg [31:0] s3_x = 30;
    reg [31:0] s3_y = 42;
    reg [31:0] s4_x = 74;
    reg [31:0] s4_y = 50;       
    reg [31:0] s5_x = 83;
    reg [31:0] s5_y = 8;
    reg [31:0] s6_x = 5;
    reg [31:0] s6_y = 50; 
    
    reg [31:0] q1_x = 17;
    reg [31:0] q1_y = 8;
    reg [31:0] q2_x = 5;
    reg [31:0] q2_y = 23;
    reg [31:0] q3_x = 76;
    reg [31:0] q3_y = 19;
    reg [31:0] q4_x = 90;
    reg [31:0] q4_y = 54;       
    reg [31:0] q5_x = 3;
    reg [31:0] q5_y = 53;
    reg [31:0] q6_x = 67;
    reg [31:0] q6_y = 9;           
    
    reg [2:0] count_blink = 0;
    reg [31:0] count_winner = 0;
    reg toggle_win = 0;
    
    //COLOR
    parameter YELLOW = 16'hffe0;
    parameter ORANGE = 16'hfd40;
    parameter ORANGE2 = 16'hfbe0;
    parameter BLACK = 16'b0;
    parameter LIGHT_BLUE = 16'h7bf; 
    parameter LIGHT_GREEN = 16'h97e0;
    
    always @ (posedge clock)
    begin
        //P
        if (toggle_win && ((x >= p_x && x <= (p_x + 6) && y >= p_y && y <= (p_y + 1)) ||
            (x >= p_x && x <= (p_x + 6) && y >= (p_y + 7) && y <= (p_y + 8)) ||
            (x >= p_x && x <= (p_x + 2) && y >= p_y && y <= (p_y + 13)) ||
            (x >= (p_x + 6) && x <= (p_x + 8) && 
            (y == (p_y + 1) || y == (p_y + 2) || y == (p_y + 6) || y == (p_y + 7))) ||
            (x >= (p_x + 7) && x <= (p_x + 9) && y >= (p_y + 2) && y <= (p_y + 6))))
        begin
            oled_data <= YELLOW;
        end
        
        //1
        else if (winner == 0 && toggle_win && ((x == p1_2_x && y >= p_y && y <= (p_y + 2)) ||
                (x >= (p1_2_x + 1) && x <= (p1_2_x + 3) && y >= p_y && y <= (p_y + 13))))
        begin
            oled_data <= YELLOW;
        end
        
        //2
        else if (winner == 1 && toggle_win && ((x >= p1_2_x && x <= (p1_2_x + 7) && y >= p_y && y <= (p_y + 2)) ||
            (x >= p1_2_x && x <= (p1_2_x + 7) && y >= (p_y + 7) && y <= (p_y + 8)) ||
            (x >= p1_2_x && x <= (p1_2_x + 7) && y >= (p_y + 11) && y <= (p_y + 13)) ||
            (x >= (p1_2_x + 6) && x <= (p1_2_x + 7) && y >= p_y && y <= (p_y + 8)) ||
            (x >= p1_2_x && x <= (p1_2_x + 1) && y >= (p_y + 8) && y <= (p_y + 13))))
        begin
            oled_data <= YELLOW;
        end
        
        //W
        else if (toggle_win && ((x >= w_x && x <= (w_x + 2) && y >= win_y && y <= (win_y + 13)) ||
                (x >= (w_x + 5) && x <= (w_x + 6) && y >= (win_y + 7) && y <= (win_y + 13)) ||
                (x >= (w_x + 9) && x <= (w_x + 11) && y >= win_y && y <= (win_y + 13)) ||
                (x >= w_x && x <= (w_x + 11) && y >= (win_y + 12) && y <= (win_y + 13))))
        begin
            oled_data <= ORANGE;
        end
        
        //I
        else if (toggle_win && (x >= i_x && x <= (i_x + 2) && y >= win_y && y <= (win_y + 13)))
        begin
            oled_data <= ORANGE;
        end
        
        //N
        else if (toggle_win && ((x >= n_x && x <= (n_x + 2) && y >= win_y && y <= (win_y + 13)) ||
                (x >= (n_x + 7) && x <= (n_x + 9) && y >= win_y && y <= (win_y + 13)) ||
                (x == (n_x + 3) && y >= win_y && y <= (win_y + 3)) ||
                (x >= (n_x + 4) && x <= (n_x + 5) && y >= (win_y + 2) && y <= (win_y + 6)) ||
                (x >= (n_x + 5) && x <= (n_x + 6) && y >= (win_y + 6) && y <= (win_y + 10))))
        begin
            oled_data <= ORANGE;
        end
        
        //GAME OVER
        //G
        else if ((x >= g_x && x <= (g_x + 1) && y >= end_y && y <= (end_y + 8)) ||
                (x >= g_x && x <= (g_x + 5) && 
                (y == end_y || y == (end_y + 1) || y == (end_y + 7) || y == (end_y + 8))) ||
                (x >= (g_x + 4) && x <= (g_x + 5) && y >= (end_y + 5) && y <= (end_y + 8)))
        begin
            oled_data <= ORANGE2;
        end    
        
        //A
        else if ((x >= a_x && x <= (a_x + 1) && y >= (end_y + 2) && y <= (end_y + 8)) ||
                (x >= (a_x + 2) && x <= (a_x + 3) && y >= end_y && y <= (end_y + 1)) ||
                (x >= (a_x + 4) && x <= (a_x + 5) && y >= (end_y + 2) && y <= (end_y + 8)) ||
                (x >= (a_x + 2) && x <= (a_x + 3) && y >= (end_y + 4) && y <= (end_y + 5)))
        begin
            oled_data <= ORANGE2;
        end          
        
        //M
        else if ((x >= m_x && x <= (m_x + 1) && y >= end_y && y <= (end_y + 8)) ||
                (x >= (m_x + 6) && x <= (m_x + 7) && y >= end_y && y <= (end_y + 8)) ||
                (x >= (m_x + 2) && x <= (m_x + 5) && y >= (end_y + 1) && y <= (end_y + 2)) ||
                (x >= (m_x + 3) && x <= (m_x + 4) && y >= (end_y + 3) && y <= (end_y + 4)))
        begin
            oled_data <= ORANGE2;
        end
        
        //E
        else if ((x >= e_x && x <= (e_x + 1) && y >= end_y && y <= (end_y + 8)) ||
                (x >= e_x && x <= (e_x + 4) && 
                (y == end_y || y == (end_y + 1) || y == (end_y + 7) || y == (end_y + 8))) ||
                (x >= e_x && x <= (e_x + 3) && y >= (end_y + 4) && y <= (end_y + 5)))
        begin
            oled_data <= ORANGE2;
        end        
        
        //O
        else if ((x >= o_x && x <= (o_x + 5) && 
                (y == end_y || y == (end_y + 1) || y == (end_y + 7) || y == (end_y + 8))) ||
                ((x == o_x || x == (o_x + 1) || x == (o_x + 4) || x == (o_x + 5)) &&
                (y >= end_y && y <= (end_y + 8))))
        begin
            oled_data <= ORANGE2;
        end       
        
        //V
        else if (((x == v_x || x == (v_x + 1) || x == (v_x + 4) || x == (v_x + 5)) &&
                (y >= end_y && y <= (end_y + 7))) ||
                (x >= (v_x + 2) && x <= (v_x + 3) && y == (end_y + 8)))
        begin
            oled_data <= ORANGE2;
        end    
      
        //E
        else if ((x >= e2_x && x <= (e2_x + 1) && y >= end_y && y <= (end_y + 8)) ||
                (x >= e2_x && x <= (e2_x + 4) && 
                (y == end_y || y == (end_y + 1) || y == (end_y + 7) || y == (end_y + 8))) ||
                (x >= e2_x && x <= (e2_x + 3) && y >= (end_y + 4) && y <= (end_y + 5)))
        begin
            oled_data <= ORANGE2;
        end 
        
        //R
        else if ((x >= r_x && x <= (r_x + 1) && y >= end_y && y <= (end_y + 8)) ||
                (x >= r_x && x <= (r_x + 4) && 
                (y == end_y || y == (end_y + 1) || y == (end_y + 4) || y == (end_y + 5))) ||
                (x >= (r_x + 4) && x <= (r_x + 5) && y >= (end_y + 1) && y <= (end_y + 3)) ||
                (x >= (r_x + 3) && x <= (r_x + 4) && y == (end_y + 6)) ||
                (x >= (r_x + 4) && x <= (r_x + 5) && y >= (end_y + 7) && y <= (end_y + 8)))
        begin
            oled_data <= ORANGE2;
        end       
        
        //SMALL SQUARE
        else if (x >= s1_x && x <= (s1_x + 1) && y >= s1_y && y <= (s1_y + 1))
        begin
            oled_data <= LIGHT_BLUE;
        end
        
        else if (x >= s2_x && x <= (s2_x + 1) && y >= s2_y && y <= (s2_y + 1))
        begin
            oled_data <= LIGHT_BLUE;
        end
        
        else if (x >= s3_x && x <= (s3_x + 1) && y >= s3_y && y <= (s3_y + 1))
        begin
            oled_data <= LIGHT_BLUE;
        end
        
        else if (x >= s4_x && x <= (s4_x + 1) && y >= s4_y && y <= (s4_y + 1))
        begin
            oled_data <= LIGHT_BLUE;
        end      
        
        else if (x >= s5_x && x <= (s5_x + 1) && y >= s5_y && y <= (s5_y + 1))
        begin
            oled_data <= LIGHT_BLUE;
        end
        
        else if (x >= s6_x && x <= (s6_x + 1) && y >= s6_y && y <= (s6_y + 1))
        begin
            oled_data <= LIGHT_BLUE;
        end  
        
                   
        else if (x >= q1_x && x <= (q1_x + 1) && y >= q1_y && y <= (q1_y + 1))
        begin
            oled_data <= LIGHT_GREEN;
        end
        
        else if (x >= q2_x && x <= (q2_x + 1) && y >= q2_y && y <= (q2_y + 1))
        begin
            oled_data <= LIGHT_GREEN;
        end
        
        else if (x >= q3_x && x <= (q3_x + 1) && y >= q3_y && y <= (q3_y + 1))
        begin
            oled_data <= LIGHT_GREEN;
        end
        
        else if (x >= q4_x && x <= (q4_x + 1) && y >= q4_y && y <= (q4_y + 1))
        begin
            oled_data <= LIGHT_GREEN;
        end      
        
        else if (x >= q5_x && x <= (q5_x + 1) && y >= q5_y && y <= (q5_y + 1))
        begin
            oled_data <= LIGHT_GREEN;
        end
        
        else if (x >= q6_x && x <= (q6_x + 1) && y >= q6_y && y <= (q6_y + 1))
        begin
            oled_data <= LIGHT_GREEN;
        end              
        
        else oled_data <= BLACK;
    end
    
    always @ (posedge clk_0p5s)
    begin
        count_blink <= (count_blink == 2) ? 0 : count_blink + 1;
        count_winner <= (count_winner == 240) ? 0 : count_winner + 1;
        
        toggle_win <= (count_winner == 0) ? ~toggle_win : toggle_win;
        
        if (count_blink == 0)
        begin
            s1_x = 4;
            s1_y = 5;
            s2_x = 64;
            s2_y = 35;
            s3_x = 30;
            s3_y = 42;
            s4_x = 74;
            s4_y = 50;       
            s5_x = 83;
            s5_y = 8;
            s6_x = 35;
            s6_y = 50; 
            
            q1_x = 17;
            q1_y = 8;
            q2_x = 24;
            q2_y = 23;
            q3_x = 76;
            q3_y = 19;
            q4_x = 90;
            q4_y = 54;       
            q5_x = 3;
            q5_y = 53;
            q6_x = 67;
            q6_y = 9; 
        end
        
        if (count_blink == 1)
        begin
            s1_x = 20;
            s1_y = 55;
            s2_x = 4;
            s2_y = 30;
            s3_x = 30;
            s3_y = 24;
            s4_x = 54;
            s4_y = 53;       
            s5_x = 90;
            s5_y = 17;
            s6_x = 54;
            s6_y = 6; 
            
            q1_x = 8;
            q1_y = 17;
            q2_x = 26;
            q2_y = 7;
            q3_x = 19;
            q3_y = 54;
            q4_x = 86;
            q4_y = 45;       
            q5_x = 32;
            q5_y = 57;
            q6_x = 20;
            q6_y = 9;         
        end
        
        if (count_blink == 2)
        begin
            s1_x = 50;
            s1_y = 25;
            s2_x = 43;
            s2_y = 3;
            s3_x = 40;
            s3_y = 20;
            s4_x = 65;
            s4_y = 53;       
            s5_x = 7;
            s5_y = 8;
            s6_x = 94;
            s6_y = 16; 
            
            q1_x = 85;
            q1_y = 2;
            q2_x = 46;
            q2_y = 47;
            q3_x = 69;
            q3_y = 4;
            q4_x = 24;
            q4_y = 43;       
            q5_x = 37;
            q5_y = 37;
            q6_x = 15;
            q6_y = 13;   
        end
    end
    
endmodule
