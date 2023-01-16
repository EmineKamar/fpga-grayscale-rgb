module AD7819_VD(
     input convst_n,
     input cs_n,
     input rd_n,
     output reg busy,
     output [7:0] data
     
      );
      
      reg[7:0] data_mem[0:9];
      reg[7:0] data_buf, i;
      reg dir;
      integer t_power_up, t1, t2, t3, t4, t5, t6, t7, t8;
      
      assign data = dir ? data_buf : 8'bz;
      
      initial
      begin
          $readmemh("dknslnld.bin", data_mem);
          i= 0;
          dir = 0;
          data_buf = 0;
      end 
  
      always @(negedge convst_n)
      begin
      
         t1 = 50;
         t2 = 30;
         t3 = 30;
         t4 = 0;
         t5 = 10;
         t6 = 10;
         t7 = 10;
         t8 = 100;
         
      end
      
      //handle busy signal
      
            
endmodule     