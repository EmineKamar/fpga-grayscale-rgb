`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2023 23:41:58
// Design Name: 
// Module Name: FT234XD_tb
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

`define clk_period 10

module FT234XD_tb();

reg clk, rst, en;
reg [7:0] data_in;
wire [7:0] data_out;
wire tx_done, rrx_done;
wire rx, tx;

FT234XD_CTRL ft234xd_ctrl(
         .clk(clk),
         .rst(rst),
         .en(en),
         .rx(rx),
         .tx(tx),
         .data_in(data_in),
         .tx_done(tx_done),
         .rx_done(rx_done),
         .data_out(data_out)
         );
 
         
FT234XD_VD ft234xd_vd(
     .rx(tx),
     .tx(rx)

    );
    
 initial clk = 1;
    always #(`clk_period/2) clk = ~clk;
 
 initial begin
    rst = 0;
    en = 0;
    #`clk_period;
    
    rst = 1;
    #`clk_period;
    
    rst = 0;
    #`clk_period;
    
    data_in = 8'h55;
    en =1;
    #`clk_period;
    
    en = 0;
    #`clk_period;
    
    #(`clk_period * 2000);
    
    $stop;
    
 end
    
    

endmodule
