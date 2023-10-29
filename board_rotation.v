`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 01:37:07
// Design Name: 
// Module Name: board_rotation
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


module board_rotation(
    input [7:0] x, y,
    output [7:0] b_x, b_y
);
    assign b_x = 7 - x;
    assign b_y = 7 - y;  
endmodule
