

`define clk_period 10

module AD7819_tb();

reg clk, rst, en;
wire done, convst_n, cs_n, rd_n, busy;
wire [7:0] data;
wire [7:0] data_bus;


 AD7819_CTRL ad7819_ctrl(
      .clk(clk),
      .rst(rst),
      .en(en),
      .done(rst),
      .db_o(data),
      .convst_n(convst_n),
      .cs_n(cs_n),
      .rd_n(rd_n),
      .busy(busy),
      .db_i(data_bus)
      

       );
       
       
AD7819_VD ad7819_vd(
      .convst_n(convst_n),
      .cs_n(cs_n),
      .rd_n(rd_n),
      .busy(busy),
      .data(data_bus)
      
      );
      
      initial clk = 1;
      always#(`clk_period/2) clk =~clk;
      
      initial begin
         rst = 0;
         en = 0;
         #`clk_period;
         
         rst=1;
         #`clk_period;
         
         rst=0;
         #(`clk_period);
         
         en =1;
         #(`clk_period);
         
         en = 0;
         #(`clk_period);
         
         #(`clk_period * 100); 
         
         $stop;
         end
         
endmodule            