`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2023 17:05:35
// Design Name: 
// Module Name: read_write_file_tb
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


module read_write_file_tb();
     
     reg [7:0] mem[15:0];
     integer i;
     integer file_id;
     
     initial
     begin
     /****
          #10
        
          $readmemb("C:\Users\emina\OneDrive\verilog\prj_read_write\test_bin.txt", mem);
          
          #10
          for(i=0; i<16; i=i+1)
          begin
              $display("%b", mem[i]);
          end
          
          #10
          *****////
          
          #10
        
        file_id = $fopen("C:\Users\emina\OneDrive\verilog\prj_read_write\test_bin.txt","w");
          
          #10
          for(i=0; i<16; i=i+1)
          begin
              $fwrite(file_id, "%02h", i);
          end
          
          #10
          $fclose(file_id);
          
          
          #10
          $finish;
          
      end
          
          
     



endmodule
