`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2026 01:50:01 AM
// Design Name: 
// Module Name: blinker
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


module blinker #(
    parameter clk_freq = 50_000_000,
    parameter on_off_ms = 1000
    )(
    input logic clk,
    output logic led
    );
     
    localparam wait_time = clk_freq / 1000 * on_off_ms;
    
    logic [31:0] counter = 0;
    logic state = 1;
    
    always_ff @ (posedge clk) begin
        if (counter == 0 || counter > wait_time) begin
            state <= ~state;
            counter <= wait_time;
        end else begin
            counter <= counter - 1'b1;
        end
    end
    
    assign led = state;
    
endmodule
