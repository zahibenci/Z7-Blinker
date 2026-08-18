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
    
    localparam blink_cycles = 50_000_000 / 1000 * 300; //  clk / 1000 * blink time in ms
    logic [23:0] timeout = 0;
    logic clean_btn_1;
    logic clean_btn_2;
    logic is_long_1;
    logic is_long_2;
    logic was_long_1;
    logic was_long_2;
    logic blink_1;
    logic blink_2;
    logic mode;  // 0: HOLD, 1: TOGGLE
    logic output_1;
    logic output_2;
    logic blink_enable_1;
    logic blink_enable_2;
    logic toggle_enable_1 = 0;
    logic toggle_enable_2 = 0;
    logic rapid_blink_1;
    logic rapid_blink_2;
    logic prev_mode = 0;
    logic is_blinking_1 = 0;
    logic is_blinking_2 = 0;
            
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
    
    mode mode_select (
        .clk(clk),
        .btn_1(clean_btn_1),
        .btn_2(clean_btn_2),
        .mode(mode)
    );
    
    rapid rapid_blinker_1 (
        .clk(clk),
        .led(rapid_blink_1)
    );
    
    rapid rapid_blinker_2 (
        .clk(clk),
        .led(rapid_blink_2)
    );        
    
    always_ff @ (posedge clk) begin
        if (prev_mode != mode) begin
            if (timeout <= blink_cycles) begin
                output_1 <= rapid_blink_1;
                output_2 <= rapid_blink_2;
                timeout <=  timeout + 1'b1;
            end else begin
                prev_mode <= mode;
                timeout <= 0;
            end
        end else if (mode == 1'b1) begin
            ////// Button_1
            if (is_long_1 == 1'b1) begin
                output_1 <= blink_1;
                is_blinking_1 <= 1'b1;
            end else begin
                if (clean_btn_1 == 0 && is_long_1 == 0) begin
                    if (toggle_enable_1 == 1'b1) begin
                        output_1 <= ~output_1;
                        toggle_enable_1 <= 0;
                    end else begin
                        output_1 <= output_1;
                    end 
                end else begin
                    toggle_enable_1 <= 1'b1;
                end
            end
            ////// Button_2
            if (is_long_2 == 1'b1) begin
                output_2 <= blink_2;
                is_blinking_2 <= 1'b1;
            end else begin
                if (clean_btn_2 == 0 && is_long_2 == 0) begin
                    if (toggle_enable_2 == 1'b1) begin
                        output_2 <= ~output_2;
                        toggle_enable_2 <= 0;
                    end else begin
                        output_2 <= output_2;
                    end 
                end else begin
                    toggle_enable_2 <= 1'b1;
                end
            end
        end else begin
            output_1 <= (is_long_1 == 1'b1) ? blink_1 : clean_btn_1;
            output_2 <= (is_long_2 == 1'b1) ? blink_2 : clean_btn_2;
        end
    end
    
    assign led_1 = output_1;
    assign led_2 = output_2;
    
endmodule
