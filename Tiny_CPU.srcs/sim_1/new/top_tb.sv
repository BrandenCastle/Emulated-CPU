`timescale 1ns / 1ps

module top_tb;

    // Inputs to the DUT (Device Under Test)
    logic [3:0] btn;    // simulates pushbuttons
    logic [1:0] sw;     // simulates switches

    // Outputs from the DUT
    logic [3:0] led;    // z, n, c, v flags on LEDs

    // Instantiate the top-level module
    top dut (
        .btn(btn),
        .sw(sw),
        .led(led)
    );

    // Simple test process
    initial begin
        // initialize everything
        btn = 4'b0000;
        sw  = 2'b00;

        $display("=== Starting ALU Hardware Button/Flag Simulation ===");

        // -----------------------------
        // CASE 1: switches = 00 -> a=7, b=3
        // -----------------------------
        sw = 2'b00;
        #10; // small delay
        $display("\nTest Vector: a=7, b=3 (sw=00)");

        // ADD (sel=0000) → no buttons
        btn = 4'b0000;
        #10;
        $display("ADD  -> led=%b  (z,n,c,v = %b)", led, led);

        // SUB (sel=0001)
        btn = 4'b0001;
        #10;
        $display("SUB  -> led=%b  (z,n,c,v = %b)", led, led);

        // AND (sel=0010)
        btn = 4'b0010;
        #10;
        $display("AND  -> led=%b  (z,n,c,v = %b)", led, led);

        // OR  (sel=0011)
        btn = 4'b0011;
        #10;
        $display("OR   -> led=%b  (z,n,c,v = %b)", led, led);

        // XOR (sel=0100)
        btn = 4'b0100;
        #10;
        $display("XOR  -> led=%b  (z,n,c,v = %b)", led, led);

        // -----------------------------
        // CASE 2: switches = 01 -> a=3, b=7
        // -----------------------------
        sw = 2'b01;
        btn = 4'b0001; // SUB
        #10;
        $display("\nTest Vector: a=3, b=7 (sw=01)");
        $display("SUB  -> led=%b  (z,n,c,v = %b)", led, led);

        // -----------------------------
        // CASE 3: switches = 10 -> a=0x7FFFFFFF, b=1 (overflow test)
        // -----------------------------
        sw = 2'b10;
        btn = 4'b0000; // ADD
        #10;
        $display("\nTest Vector: a=0x7FFFFFFF, b=1 (sw=10)");
        $display("ADD  -> led=%b  (z,n,c,v = %b)", led, led);

        // -----------------------------
        // CASE 4: switches = 11 -> a=9, b=9 (zero result)
        // -----------------------------
        sw = 2'b11;
        btn = 4'b0001; // SUB
        #10;
        $display("\nTest Vector: a=9, b=9 (sw=11)");
        $display("SUB  -> led=%b  (z,n,c,v = %b)", led, led);

        $display("\n=== Simulation Complete ===");
        $stop;
    end

endmodule