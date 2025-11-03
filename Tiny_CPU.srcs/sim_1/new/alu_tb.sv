`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2025 02:33:39 PM
// Design Name: 
// Module Name: alu_tb
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


module alu_tb;

logic [3:0] sel;
logic [31:0] a, b;
logic [31:0] res;

CPU_alu dut (
    .sel(sel),
    .a(a),
    .b(b),
    .res(res)
);


initial begin
    
    //add
    a = 32'd7;
    b = 32'd5;
    sel = 4'b0000;
    #100;
    
    //sub
    a = 32'd2;
    b = 32'd1;
    sel = 4'b0001;
    #100
    
    //and
    a = 32'd2;
    b = 32'd1;
    sel = 4'b0010;
    #100
    
    //or
    a = 32'd2;
    b = 32'd1;
    sel = 4'b0011;
    #100
     
    //xor
    a = 32'd2;
    b = 32'd1;
    sel = 4'b0100;
    #100

    //SLT 
    a = 32'd2;
    b = 32'd1;
    sel = 4'b0101;
    #100    

    //SLL 
    a = 32'd2;
    b = 32'd1;
    sel = 4'b0110;
    #100 
    
    //SRL 
    a = 32'd2;
    b = 32'd1;
    sel = 4'b0111;
    #100     
    
    $finish;
end

endmodule
