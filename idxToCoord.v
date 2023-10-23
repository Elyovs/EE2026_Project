`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2023 01:04:37
// Design Name: 
// Module Name: idxToCoord
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


module idxToCoord(input [12:0] pixel_idx, output [6:0] x, y);
    
    assign x = pixel_idx % 96;
    assign y = pixel_idx / 96;
    
endmodule