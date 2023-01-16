`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2023 19:13:55
// Design Name: 
// Module Name: AD7819_CTRL
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


module AD7819_CTRL(
      input clk,
      input rst,
      input en,
      output reg done,
      output reg [7:0] db_o,
      output reg convst_n,
      output reg cs_n,
      output reg rd_n,
      input busy,
      input [7:0] db_i
      

       );
       
       
       localparam s_idle =  6'b000001,
                   s_start = 6'b000010,
                   s_busy  = 6'b000100,
                   s_read_m =6'b001000,
                   s_read_e =6'b010000,
                   s_done =  6'b100000;
                   
                   
       localparam t2 = 5,
                  t8 = 10,
                  t_read = 10,
                  t_done = 1;
                  
                  
       reg [5:0] cur_state, next_state;
       reg [7:0] time_count;
       reg en_count;
       
       always @(posedge clk or posedge rst)
           if (rst) begin
               cur_state <= s_idle;
           end else begin
               cur_state <= next_state;
           end
           
           
       always @(posedge clk or posedge rst)
          if (rst) begin
              time_count <=8'd0;
          end else if (en_count ==0) begin
               time_count <=8'd0;
          end else begin
               time_count <= time_count + 1;
          end
          
          
        always@(*)
           if (rst) begin
                next_state = s_idle;
                convst_n = 1'b1;
                en_count = 1'b0;
                cs_n = 1'b1;
                rd_n = 1'b1;
                done = 1'b0;
                db_o = 8'd0;
            end else begin
                 case(cur_state)
                     s_idle:  if (en== 1) begin
                                 next_state = s_start;
                                 en_count = 1'b1;
                                 done = 1'b0;
                               end else begin
                                  next_state = s_idle;
                               end
                               
                               
                     s_start:   if (time_count==t2) begin
                                    convst_n = 1'b1;
                                    en_count = 1'b0;
                                    next_state = s_busy;
                                end else begin
                                     convst_n = 1'b0;
                                     next_state = s_start;
                                end
                                
                      s_busy:    if (busy== 1) begin
                                     next_state = s_busy;
                                 end else begin
                                      cs_n = 1'b0;
                                      rd_n = 1'b0;
                                      next_state = s_read_m;
                                  end
                      
                      
                      s_read_m:   if (time_count == t_read/2) begin
                                      db_o = db_i;
                                      en_count = 1'b0;
                                      next_state = s_read_e;
                                   end else begin
                                       en_count = 1'b1;
                                       next_state = s_read_m;
                                    end
                        
                       s_read_e:    if (time_count == t8) begin
                                        en_count = 1'b0;
                                        done = 1'b1;
                                        next_state = s_idle;
                                     end else begin
                                         en_count = 1'b1;
                                         next_state = s_read_e;
                                      end
                                      
                         s_done:      if (time_count == t8) begin
                                          en_count = 1'b0;
                                          done = 1'b1;
                                          next_state = s_idle;
                                       end else begin
                                           en_count = 1'b1;
                                           next_state = s_done;
                                       end
                                
                          default: begin next_state = s_idle; end
                     endcase
                  end                   
       
       
       
       
       
                   
                   
                   
endmodule
