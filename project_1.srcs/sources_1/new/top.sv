`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2026 10:22:26 PM
// Design Name: 
// Module Name: top
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


module top(
    input logic clk,
    input logic btn_1,
    input logic btn_2,
    output logic led_1,
    output logic led_2
    );
    
    logic clean_btn_1;
    logic clean_btn_2;
    logic is_long_1;
    logic is_long_2;
    logic blink_1;
    logic blink_2;
    
    debouncer debounce_1 (
        .clk(clk),
        .bouncy_btn(btn_1),
        .debounced_btn(clean_btn_1)
    );
    debouncer debounce_2 (
        .clk(clk),
        .bouncy_btn(btn_2),
        .debounced_btn(clean_btn_2)
    );
    
    blinker blinker_1 (
        .clk(clk),
        .led(blink_1)
    );
    
    blinker blinker_2 (
        .clk(clk),
        .led(blink_2)
    );
    
    counter counter_1 (
        .clk(clk),
        .btn(clean_btn_1),
        .is_long_press(is_long_1)
    );
    
    counter counter_2 (
        .clk(clk),
        .btn(clean_btn_2),
        .is_long_press(is_long_2)
    );
    
    assign led_1 = (is_long_1 == 1'b1) ? blink_1 : clean_btn_1;
    assign led_2 = (is_long_2 == 1'b1) ? blink_2 : clean_btn_2;
    
endmodule
