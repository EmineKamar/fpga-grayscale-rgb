`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2023 22:39:40
// Design Name: 
// Module Name: FT234XD_CTRL
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


module FT234XD_CTRL(
     input clk,
     input rst,
     input en,
     input rx,
     input [7:0] data_in,
     output tx,
     output [7:0] data_out,
     output tx_done,
     output rx_done
    );
    
FT234XD_TX ft234xd_tx(
         .clk(clk),
         .rst(rst),
         .en(en),
         .tx(tx),
         .data_in(data_in),
         .tx_done(tx_done)
         );
         
FT234XD_RX ft234xd_rx(
         .clk(clk),
         .rst(rst),
         .data_out(data_out),
         .rx_done(rx_done)
         );
         
         
endmodule
