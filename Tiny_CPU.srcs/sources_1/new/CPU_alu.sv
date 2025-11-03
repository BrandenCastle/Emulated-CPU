`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2025 09:41:37 AM
// Design Name: 
// Module Name: CPU_alu
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


module CPU_alu(
input [3:0] sel,//selector
input [31:0] a,b,//inputs

output logic [31:0] res,//result
output logic z,//zero
output logic n,//negative
output logic c,//carry
output logic v//overflow

    );
    
logic [32:0] add_tmp;
logic [32:0] sub_tmp;
    
    //uses the selector to choose the operation
    always_comb
    begin
    
    
    res = 32'd0;
    z   = 1'b0;
    n   = 1'b0;
    c   = 1'b0;
    v   = 1'b0;
    
add_tmp = {1'b0, a} + {1'b0, b};
sub_tmp = {1'b0, a} - {1'b0, b};
    
    
        unique case (sel)

            4'b0000: begin // ADD
                res = add_tmp[31:0];     // normal 32-bit sum
                c   = add_tmp[32];       // carry out (unsigned)
                v   = (a[31] == b[31]) && (res[31] != a[31]); // signed overflow
            end

            4'b0001: begin // SUB (a - b)
                res = sub_tmp[31:0];     // normal 32-bit difference
                c   = sub_tmp[32];       // borrow flag (see below)
                v   = (a[31] != b[31]) && (res[31] != a[31]); // signed overflow for sub
            end

            4'b0010: begin // AND
                res = a & b;
            end

            4'b0011: begin // OR
                res = a | b;
            end

            4'b0100: begin // XOR
                res = a ^ b;
            end

            4'b0101: begin // SLT (set less than, signed)
                res = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            end

            4'b0110: begin // SLL (shift left logical)
                res = a << b[4:0];
            end

            4'b0111: begin // SRL (shift right logical)
                res = a >> b[4:0];
            end

            default: begin
                res = 32'd0;
            end
        endcase

        // flags that depend ONLY on the final res value
        z = (res == 32'd0); // zero flag
        n = res[31];        // negative flag (MSB of result)
    end

endmodule
