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
    wire end_bool;
    wire player;
    
    wire [3:0] state;
    wire [2:0]old_x;
    wire [2:0]old_y;
    wire [2:0]new_x;
    wire [2:0]new_y;
    wire [63:0]avail_array;
//    wire [3:0] state = 0;
//    wire [2:0]old_x = 3;
//    wire [2:0]old_y = 3;
//    wire [2:0]new_x = 3;
//    wire [2:0]new_y = 3;
//    wire [63:0]avail_array = 0;
    
    wire [2:0] cursor_x; 
    wire [2:0] cursor_y;
    wire bool_moved;
    
//    wire [1:0] check = 0;
    wire [1:0] check;     
    wire [1:0] checkmate; 
    
//    wire [2:0]cursor_x = 0; 
//    wire [2:0]cursor_y = 0;
//    wire bool_moved = 0;
    
//    wire [1:0] check = 0;
    
    
    // OLED Display
    wire [31:0] count_6p25 = 7;
    wire clk_6p25;
    flexible_clock clk6p25m (.basys_clk(clock), .count_in(count_6p25), .out_clk(clk_6p25));
    
    wire frame_beg, send_pix, sample_pix;
    reg [15:0] oled_data;
    wire [12:0] pix_index;
    
    wire [15:0] oled_data_menu;
    wire [15:0] oled_data_board;
    wire [15:0] oled_data_end;
    
    wire curr_turn;
//    wire end_bool = 0;
    wire winner;    

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
        .JA(JA[1:0]),
        .pix_index(pix_index),
        .oled_data(oled_data_menu),
        .start(start),
        .player(player)
    );

    
    

        
    chess_engine chess_moves (
        .CLOCK(clock),
        .player(curr_turn),
        .coordX(cursor_x),
        .coordY(cursor_y),
        .old_posX(old_x),
        .old_posY(old_y),
        .new_posX(new_x),
        .new_posY(new_y),
        .avail_moves_out(avail_array),
        .piece_selected(state),
        .moved(bool_moved),
        .check(check),
        .checkmate(checkmate)
        );
        

    
    board_art visuals(
        .clock(clock), 
        .old_x(old_y),  //y to x because in other module it's x and y
        .old_y(old_x),
        .new_x(new_y),
        .new_y(new_x),
        .pix_index(pix_index), 
        .oled_data(oled_data_board),
        .player(player),
        .PS2Clk(PS2Clk),
        .PS2Data(PS2Data),
        .avail_array(avail_array),
        .state(state),
        .cursor_x(cursor_y),
        .cursor_y(cursor_x),
        .JA(JA[7:2]),
        .JB(JB[7:2]),
        .curr_player_turn(curr_turn),
        .check(check),
        .moved(bool_moved)
    );
    
    player_turn_1_min turns(
        .clock(clock), 
        .moved(bool_moved),
        .player_turn(curr_turn), 
        .end_game(end_bool), 
        .winner(winner),
        .checkmate(checkmate)
    );
    
    end_game end_g(
        .clock(clock), 
        .winner(winner),
        .pix_index(pix_index),
        .oled_data(oled_data_end)
    );        
    
//    assign led[0] = bool_moved;
    
    always @ (posedge clk_6p25)
    begin
        if (start == 0)
        begin
            //menu
            oled_data <= oled_data_menu;
        end
        else if (start && end_bool != 1)
        begin
            //board
            oled_data <= oled_data_board;
        end
        else 
        begin
            //game over
            oled_data <= oled_data_end;
        end
    end
    
endmodule

module flexible_clock(input basys_clk, input [31:0] count_in, output reg out_clk);

    reg [31:0] count = 0;
    
    always @ (posedge basys_clk) begin
        count <= (count == count_in) ? 0 : count + 1;
        out_clk <= (count == 0) ? ~out_clk : out_clk;
    end

endmodule