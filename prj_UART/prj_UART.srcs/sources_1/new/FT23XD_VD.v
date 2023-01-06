`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2023 21:55:52
// Design Name: 
// Module Name: FT23XD_VD
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


module FT234XD_VD(
     input rx,
     output reg tx

    );
    
integer t_1_bit;
reg start_bit, stop_bit, rx_done;
reg [7:0] rx_data;

initial
begin

   t_1_bit = 500;
   rx_data = 8'd00;
   rx_done = 0;
   start_bit = 0;
   tx = 1;
  

end


always @(posedge rx)
    begin
        rx_data = 8'd00;
        rx_done = 0;
        #(t_1_bit/2) start_bit = rx;
        if ( start_bit ==0 )
        begin
            #(t_1_bit) rx_data[0] = rx;
            #(t_1_bit) rx_data[1] = rx;
            #(t_1_bit) rx_data[2] = rx;
            #(t_1_bit) rx_data[3] = rx;
            #(t_1_bit) rx_data[4] = rx;
            #(t_1_bit) rx_data[5] = rx;
            #(t_1_bit) rx_data[6] = rx;
            #(t_1_bit) rx_data[7] = rx;
            #(t_1_bit) stop_bit = rx;
            #(t_1_bit) 
            if ( stop_bit== 1)
            begin
                rx_done = 1;
            end else begin
                rx_done = 0;
            end
        end  
    end                    
      
 always @(rx_done)
     begin
        if (rx_done == 1)
        begin
            tx = 0;
            #(t_1_bit)
            tx = rx_data[0];
            #(t_1_bit)
            tx = rx_data[1]; 
            #(t_1_bit)
            tx = rx_data[2]; 
            #(t_1_bit)
            tx = rx_data[3]; 
            #(t_1_bit)
            tx = rx_data[4]; 
            #(t_1_bit)
            tx = rx_data[5]; 
            #(t_1_bit)
            tx = rx_data[6]; 
            #(t_1_bit)
            tx = rx_data[7];       
            #(t_1_bit)
            tx = 1;
            #(t_1_bit)
            tx=1;
        end
     end    


endmodule
