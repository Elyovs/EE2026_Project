`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2023 01:29:18
// Design Name: 
// Module Name: comms
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


module comms(
    input [1:0] JA, input [2:0] sw, output [2:0] led, 
    output [1:0] JB
    );
    assign JB[0] = sw[0];
    assign JB[1] = sw[1];
    
    assign led[0] = JA[0];
    assign led[1] = JA[1];

endmodule
