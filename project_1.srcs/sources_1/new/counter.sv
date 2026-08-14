`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2026 11:17:11 PM
// Design Name: 
// Module Name: counter
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


module counter #(
    parameter blink_threshold_ms = 500,
    parameter clk_freq = 50_000_000
    )(
    input logic clk,
    input logic btn,
    output logic is_long_press
    );
    
    logic [30:0] counter = 0;
    logic is_long_tmp = 0;
    
    localparam wait_cycles = clk_freq / 1000 * blink_threshold_ms;
    
    always_ff @ (posedge clk) begin
        if (btn == 0) begin
            if (counter >= wait_cycles) begin
                counter <= counter;
                is_long_tmp <= 1'b1;
            end else begin
                counter <= counter + 1'b1;
                is_long_tmp <= 0;
            end            
        end else begin
            counter <= 0;
            is_long_tmp <= 0;
        end
    end
    
    //own, less elegant solution
    //always_ff @(posedge clk) begin
        //if (btn == 0) begin
            //if (counter >= wait_cycles) begin
                //counter <= 0;
                //is_long_tmp <= 1'b1;
           // end else if (is_long_tmp == 1'b1) begin
                //counter <= 0;
                //is_long_tmp <= 1'b1;
            //end else begin
                //counter <= counter + 1'b1;
                //is_long_tmp <= 0;
            //end
       // end else begin 
           // counter <= 0;
           // is_long_tmp <= 0;
        //end
   // end
   
   assign is_long_press = is_long_tmp;
   
endmodule
