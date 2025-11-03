`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2025 09:52:21 AM
// Design Name: 
// Module Name: register_tb
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


module register_tb;
parameter int DATA_W = 8;
parameter int NUM_REGS = 8;
logic clk, we, reset;
logic [$clog2(NUM_REGS)-1:0] wa, RA1, RA2;
logic [DATA_W-1:0] write_data, RD1, RD2;

register #(
    .DATA_W(DATA_W),
    .NUM_REGS(NUM_REGS)
) dut (
    .clk(clk),
    .we(we),
    .reset(reset),
    .wa(wa),
    .write_data(write_data),
    .RA1(RA1),
    .RA2(RA2),
    .RD1(RD1),
    .RD2(RD2)
);

initial begin
  clk = 1'b0;
  forever #5 clk = ~clk;   // 10 ns period
end

initial begin
  // defaults
  we = 0; wa = '0; write_data = '0; RA1 = '0; RA2 = '0;

//reset
  reset = 1;
  @(posedge clk);
  @(posedge clk);
  reset = 0;

  // check that registers are reset
  RA1 = '0; RA2 = NUM_REGS-1; #1;
  assert (RD1 == '0) else $error("After reset RD1 != 0");
  assert (RD2 == '0) else $error("After reset RD2 != 0");

  // write reg[3] = A5 on the next clock edge
  we = 1; wa = 3; write_data = 8'hA5;
  @(posedge clk);
  we = 0;

  // readback and check
  RA1 = 3; RA2 = 3; #1;
  assert (RA1 < NUM_REGS) else $error("RA1 OOB");
  assert (RA2 < NUM_REGS) else $error("RA2 OOB");
  assert (wa  < NUM_REGS) else $error("WA  OOB");
  assert (RD1 == 8'hA5)   else $error("RD1 mismatch at addr 3");
  assert (RD2 == 8'hA5)   else $error("RD2 mismatch at addr 3");

  @(posedge clk);
  $finish;
end


endmodule

