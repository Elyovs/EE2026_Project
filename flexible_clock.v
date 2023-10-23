`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2023 14:46:33
// Design Name: 
// Module Name: flexible_clock
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


module flexible_clock(input basys_clk, input [31:0] count_in, output reg out_clk);

    reg [31:0] count = 0;
    
    always @ (posedge basys_clk) begin
        count <= (count == count_in) ? 0 : count + 1;
        out_clk <= (count == 0) ? ~out_clk : out_clk;
    end

endmodule
