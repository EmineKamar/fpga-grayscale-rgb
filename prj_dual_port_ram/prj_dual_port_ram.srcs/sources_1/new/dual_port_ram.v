`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2022 14:22:33
// Design Name: 
// Module Name: dual_port_ram
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


module dual_port_ram(
    //it has two sets of address and data bus
    input [7:0] data_a, data_b,  //data bus a, and bus b;
    input [5:0] addr_a, addr_b,  //address bus a and b;
    input we_a, we_b,  //seperated write and read signal;
    input clk,
    output reg [7:0] q_a, q_b  //two sets of output data bus;
    

    );
    
    //define the ram
    reg [7:0] ram[63:0]; //64*8 bit;
    
    //port A operation;
    always @ (posedge clk)
    begin
        if (we_a)  //high level is write
        begin
            ram[addr_a] <= data_a; //save input data a input memory
        end
        else
        begin
            q_a <= ram[addr_a]; //read data output;
        end
     end
     
     //Port B
     always @ (posedge clk)
    begin
        if (we_b)  //high level is write
        begin
            ram[addr_b] <= data_b; //save input data a input memory
        end
        else
        begin
            q_b <= ram[addr_b]; //read data output;
        end
     end
                 
endmodule
