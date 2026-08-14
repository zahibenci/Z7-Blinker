`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2026 11:23:03 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer #(
    parameter clk_freq = 50_000_000,
    parameter debounce_ms = 10
)(
    input logic clk,
    input logic bouncy_btn,
    output logic debounced_btn
);

    localparam cycle_count = (clk_freq / 1000) * debounce_ms;
    
    logic sync_0, sync_1;
    always_ff @ (posedge clk) begin
         sync_0 <= bouncy_btn;
         sync_1 <= sync_0;
    end    
    
    logic state = 1;
    logic [19:0] counter = 0;
       
    always_ff @ (posedge clk) begin
        if (state != sync_1) begin
            counter <= counter + 1'b1;
            if (counter >= cycle_count) begin
                state <= sync_1;
                counter <= 0;
            end
        end else begin
            counter <= 0;
        end        
    end
    
    assign debounced_btn = state;
endmodule
