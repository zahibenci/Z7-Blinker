`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/14/2026 11:21:49 PM
// Design Name: 
// Module Name: tb
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


module tb();
    logic clk = 0;
    logic btn_1 = 1;
    logic btn_2 = 1;
    logic led_1;
    logic led_2;
    
    top uut (
        .clk(clk),
        .btn_1(btn_1),
        .btn_2(btn_2),
        .led_1(led_1),
        .led_2(led_2)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        #10;        // Wait 100 nanoseconds
        btn_1 = 0;   // Push the button down
        #60;     // Hold it down for a while
        btn_1 = 1;   // Let go
        #160;
        btn_1 = 0;
        #6;
        btn_1 = 1;
        #6;
        btn_1 = 0;
        #6;
        btn_1 = 1;
    end
    
endmodule
