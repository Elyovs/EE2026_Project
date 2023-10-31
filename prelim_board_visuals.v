`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 22:15:18
// Design Name: 
// Module Name: board_visuals
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


module board_visualisation (  
    input clock, btnC, btnU,
    input [3:0] sw,
    output [7:0] JC,
    output reg [15:0] led,
    inout PS2Clk, inout PS2Data
    );    
    
    wire fb, sp, samp;    
    reg [15:0] oled_data = 16'b00000_000000_00000;    
    wire [12:0] pix_index;
    wire [7:0] x;
    wire [6:0] y;
   
    wire [31:0] count_6p25 = 7;
    wire clk_6p25;
    flexible_clock clk6p25m (.basys_clk(clock), .count_in(count_6p25), .out_clk(clk_6p25)); 
   
    Oled_Display oled_data_A (
        .clk(clk_6p25),         
        .reset(0), 
        .frame_begin(fb),         
        .sending_pixels(sp),
        .sample_pixel(samp),         
        .pixel_index(pix_index), 
        .pixel_data(oled_data),         
        .cs(JC[0]), 
        .sdin(JC[1]), 
        .sclk(JC[3]),         
        .d_cn(JC[4]), 
        .resn(JC[5]),         
        .vccen(JC[6]),
        .pmoden(JC[7])    
    );

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
        
        
    assign x = pix_index%96;
    assign y = pix_index/96;
    
    
    parameter WHITE = 16'b11111_111111_11111;
    parameter BLACK = 16'b00000_000000_00000;
    parameter LIGHT_BLUE = 16'b01111_110111_10111;
    
        
    always @ (posedge clock)
    begin

        //mouse cursor
        if (((x >= x_pos - 1 && x <= x_pos + 1) && y == y_pos) || 
            (x == x_pos && (y >= y_pos - 1 && y <= y_pos + 1)))
        begin
            oled_data <= LIGHT_BLUE;
        end
        
        else if ((x == x_pos - 1 && (y == y_pos - 1 || y == y_pos + 1)) ||
            (x == x_pos + 1 && (y == y_pos - 1 || y == y_pos + 1)))
        begin
            oled_data <= BLACK;
        end
        
        //board
         else if (x > 16 && x < 81 && 
            (((y <= 7) || (y >= 16 && y < 24) || (y >= 32 && y <40) || (y >= 48 && y < 56)) && 
            ((x >= 16 && x < 24) || (x >= 32 && x < 40) || (x >= 48 && x < 56) || (x >= 64 && x < 72))) ||
            (((y >= 8 && y < 16) || (y >= 24 && y < 32) || ( y >= 40 && y < 48) || (y >= 56)) &&
            ((x >= 24 && x < 32) || ( x >= 40 && x < 48) || (x >= 56 && x < 64) || (x >= 72 && x < 80))) )       
         begin
            oled_data <= 16'b11111_111111_11111;
         end
         
          else if (x <= 16 || x > 80)
          begin
            oled_data <= 16'b00000_000000_00000;
          end
                

         else begin
            oled_data <= 16'b10010_010011_00010;
         end
         
         if(lmr[2] && x_pos >= 17 && x_pos <= 24) led[0] <= 1;
         else led[0] <= 0;
         if(lmr[2] && x_pos >= 25 && x_pos <= 32) led[1] <= 1;
         else led[1] <= 0;
         if(lmr[2] && x_pos >= 33 && x_pos <= 40) led[2] <= 1;
         else led[2] <= 0;
         if(lmr[2] && x_pos >= 41 && x_pos <= 48) led[3] <= 1;
         else led[3] <= 0;
         if(lmr[2] && x_pos >= 49 && x_pos <= 56) led[4] <= 1;
         else led[4] <= 0;
         if(lmr[2] && x_pos >= 57 && x_pos <= 64) led[5] <= 1;
         else led[5] <= 0;
         if(lmr[2] && x_pos >= 65 && x_pos <= 72) led[6] <= 1;
         else led[6] <= 0;
         if(lmr[2] && x_pos >= 73 && x_pos <= 80) led[7] <= 1;
         else led[7] <= 0;
         
         if(lmr[2] && y_pos >= 0 && y_pos <= 7) led[8] <= 1;
         else led[8] <= 0;
         if(lmr[2] && y_pos >= 8 && y_pos <= 15) led[9] <= 1;
         else led[9] <= 0;
         if(lmr[2] && y_pos >= 16 && y_pos <= 23) led[10] <= 1;
         else led[10] <= 0;
         if(lmr[2] && y_pos >= 24 && y_pos <= 31) led[11] <= 1;
         else led[11] <= 0;
         if(lmr[2] && y_pos >= 32 && y_pos <= 39) led[12] <= 1;
         else led[12] <= 0;
         if(lmr[2] && y_pos >= 40 && y_pos <= 47) led[13] <= 1;
         else led[13] <= 0;
         if(lmr[2] && y_pos >= 48 && y_pos <= 55) led[14] <= 1;
         else led[14] <= 0;
         if(lmr[2] && y_pos >= 56 && y_pos <= 63) led[15] <= 1;
         else led[15] <= 0;
    end
            
endmodule    
