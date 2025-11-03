`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2025 09:34:15 AM
// Design Name: 
// Module Name: register
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

module register #(
parameter int DATA_W = 8,//data width
parameter int NUM_REGS = 8//no of registers
) (
    input  logic                 clk, we, reset,  //clock, write enable, and reset
    input  logic [$clog2(NUM_REGS)-1:0] wa,          // write address
    input  logic [DATA_W-1:0]    write_data,         // write data
    input  logic [$clog2(NUM_REGS)-1:0] RA1, RA2,    // read address
    output logic [DATA_W-1:0]    RD1, RD2            // read data
);

    // Register storage
    logic [DATA_W-1:0] regs [NUM_REGS-1:0];

    // Synchronous reset & write
    always_ff @(posedge clk) begin
        if (reset) begin
            for (int i = 0; i < NUM_REGS; i++) begin
                regs[i] <= '0;                  // width-safe zero
            end
        end
        else if (we) begin
            regs[wa] <= write_data;
        end
    end

    // Combinational reads
    always_comb begin
        RD1 = regs[RA1];
        RD2 = regs[RA2];
    end

endmodule