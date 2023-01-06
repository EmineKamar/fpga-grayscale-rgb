`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2023 22:47:45
// Design Name: 
// Module Name: FT234XD_TX
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


module FT234XD_TX(
     input clk,
     input rst,
     input en,
     input [7:0] data_in,
     output reg tx,
     output reg tx_done

      );
      
      localparam s_idle = 5'b00001,
                 s_start= 5'b00010,
                 s_wr   = 5'b00100,
                 s_stop = 5'b01000,
                 s_done = 5'b10000;
                 
       localparam t_1_bit = 50;
       
       reg [4:0] cur_state, next_state;
       reg [7:0] time_count;
       reg en_count;
       reg [7:0] tx_bits;
       
       always @(posedge clk or posedge rst)
           if (rst) begin
               cur_state <= s_idle;
           end else begin
                cur_state <= next_state;
           end
           
        always @(posedge clk or posedge rst)
            if (rst) begin
                time_count <= 8'd0;
            end else if (en_count == 0) begin
                time_count <= 8'd0;
            end else begin
                time_count <= time_count + 1;
            end
         
         always @(*)
           if (rst) begin
               next_state = s_idle;
               en_count = 1'b0;
               tx= 1;
               tx_done = 1'b0;
               tx_bits = 8'b0;
            end else begin
                case (cur_state)
                    s_idle:   if (en==1) begin
                                  next_state = s_start;
                                  en_count = 1'b1;
                                  tx_done = 1'b0;
                               end else begin
                                   next_state = s_idle;
                                end
                                
                    s_start:   if (time_count == t_1_bit) begin
                                   en_count = 1'b0;
                                   next_state = s_wr;
                                end else begin 
                                    tx = 0;
                                    next_state = s_start;
                                end
                                 
                    s_wr:       if (time_count == t_1_bit) begin
                                    en_count =1'b0;
                                    if (tx_bits== 8'd7)
                                        next_state = s_stop;
                                    else begin
                                        tx_bits = tx_bits + 1;
                                        next_state = s_wr;
                                    end
                                end else begin
                                     en_count = 1'b1;
                                     tx = data_in[tx_bits];
                                     next_state = s_wr;
                                 end
                                 
                     s_stop:      if (time_count == t_1_bit) begin
                                       en_count = 1'b0;
                                       next_state = s_done;
                                  end else begin
                                       en_count = 1'b1;
                                       tx = 1'b1;
                                       next_state = s_stop;
                                  end
                                  
                     s_done:       if (time_count == 1) begin
                                        en_count= 1'b0;
                                        tx_done = 1'b0;
                                        next_state = s_idle;
                                    end else begin
                                        en_count = 1'b1;
                                        tx_done = 1'b1;
                                        next_state = s_done;
                                    end
                                    
                      default: begin next_state = s_idle; end
                 endcase
                 
            end
                                  
               
endmodule
