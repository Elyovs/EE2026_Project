`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: TAN EN-MIIN ELIZABETH
//  STUDENT B NAME: PIER CHIA SHAO RONG
//  STUDENT C NAME: DAVID CHONG JOON WEI
//  STUDENT D NAME: ELLA YOVITA SUWIBOWO 
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input btnC, clock, input [15:0] sw, input [7:0] JB, 
    output [15:0] led, output [7:0] JA, JC, output [6:0] seg,
    output [3:0] an, output dp,
    inout PS2Clk, inout PS2Data
);

    wire start;
    wire player;
    
    
    // OLED Display
    wire [31:0] count_6p25 = 7;
    wire clk_6p25;
    flexible_clock clk6p25m (.basys_clk(clock), .count_in(count_6p25), .out_clk(clk_6p25));
    
    wire frame_beg, send_pix, sample_pix;
    reg [15:0] oled_data;
    wire [12:0] pix_index;
    
    wire [15:0] oled_data_menu;
    wire [15:0] oled_data_board;

    Oled_Display unit_oled_A (
        .clk(clk_6p25), 
        .reset(0), 
        .frame_begin(frame_beg), 
        .sending_pixels(send_pix),
        .sample_pixel(sample_pix), 
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
    
    menu main_menu (
        .clock(clock), 
        .sw(sw), 
        .btnC(btnC), 
        .JB(JB), 
        .JC(JC),
        .seg(seg),
        .led(led),
        .an(an),
        .dp(dp),
        .JA(JA),
        .pix_index(pix_index),
        .oled_data(oled_data_menu),
        .start(start),
        .player(player)
    );
    
    board_art visuals(
        .clock(clock), 
        .pix_index(pix_index), 
        .oled_data(oled_data_board),
        .player(player),
        .PS2Clk(PS2Clk),
        .PS2Data(PS2Data)
    );
    
    always @ (posedge clk_6p25)
    begin
        if (start == 0)
        begin
        //menu
            oled_data <= oled_data_menu;
        end
        else
        begin
        //board
            oled_data <= oled_data_board;
        end
    end
    
endmodule
