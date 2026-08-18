`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2026 12:28:14 PM
// Design Name: 
// Module Name: mode
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


module mode #(
    parameter clk_freq = 50_000_000,
    parameter wait_time_ms = 2000
)(
    input logic clk,
    input logic btn_1,
    input logic btn_2,
    output logic mode
    );
    
    localparam wait_cycles = clk_freq / 1000 * wait_time_ms;
    
    logic [27:0] counter = 0;
    
    always_ff @ (posedge clk) begin
        if (btn_1 == 0 && btn_2 == 0) begin
            if (counter >= wait_cycles) begin
                counter <= 0;
                mode <= ~mode;
            end else begin
                counter = counter + 1'b1;
                mode <= mode;
            end
        end else begin
            counter <= 0;
            mode <= mode;
        end
    end
    
endmodule
