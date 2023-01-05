`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.01.2023 16:54:30
// Design Name: 
// Module Name: fpga_sobel_top
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


module fpga_sobel_top(
    input sys_clk_i,
    input sys_rst_i,

    output xvclk_o,
    output sio_c_o,
    inout sio_d_io,
    output cam_rst_o,
    output cam_pwd_o,

    input vsync_i,
    input href_i,
    input pclk_i,
    input [7:0] cam_data_i,

    output scl_o,
    inout sda_io,

    output clk_n_o,
    output clk_p_o,

    output [2:0] hdmi_data_o

    );


    wire  [7:0] cam_red_o;
    wire [7:0] cam_green_o;
    wire [7:0] cam_blue_o;

    wire cam_done_o;

    wire [7:0] sobel_red_o;
    wire [7:0] sobel_green_o;
    wire [7:0] sobel_blue_o;

    wire sobel_done_o;
   // wire [2:0] hdmi_data_o;
    
cam_mod CAM_MOD(
    .sys_clk_i(sys_clk_i),
    .sys_rst_i(sys_rst_i),

    .xvclk_o(xvclk_o),
    .sio_c_o(sio_c_o),
    .sio_d_io(sio_d_io),
    .cam_rst_o(cam_rst_o),
    .cam_pwd_o(cam_pwd_o),

    .vsync_i(vsync_i),
    .href_i(href_i),
    .pclk_i(pclk_i),
    .cam_data_i(cam_data_i),

    .cam_red_o(cam_red_o),
    .cam_green_o(cam_green_o),
    .cam_blue_o(cam_blue_o),

    .cam_done_o(cam_done_o)
    );

sobel_mod SOBEL_MOD(
    .sys_clk_i(sys_clk_i),
    .sys_rst_i(sys_rst_i),
     
    .cam_red_i(cam_red_o),
    .cam_green_i(cam_green_o),
    .cam_blue_i(cam_blue_o),

    .cam_done_i(cam_done_o),

    .sobel_red_o(sobel_red_o),
    .sobel_green_o(sobel_green_o),
    .sobel_blue_o(sobel_blue_o),

    .sobel_done_o(sobel_done_o)


     );

hdmi_mod HDMI_MOD(
    .sys_clk_i(sys_clk_i),
    .sys_rst_i(sys_rst_i),

    .red_i(sobel_red_o),
    .green_i(sobel_green_o),
    .blue_i(sobel_blue_o),

    .done_i(sobel_done_o),

    .scl_o(scl_o),
    .sda_io(sda_io),

    .clk_n_o(clk_n_o),
    .clk_p_o(clk_p_o),

    .hdmi_data_o(hdmi_data_o)




    );

endmodule
