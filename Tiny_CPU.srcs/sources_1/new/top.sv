module top (
    input  logic [3:0] btn,   // buttons on the board
    input  logic [1:0] sw,    // 2 switches on the board
    output logic [3:0] led    // 4 LEDs on the board
);

    // We'll drive sel from the 4 buttons
    logic [3:0] sel;
    assign sel = btn;

    // We'll choose a and b based on the 2-bit switch value
    logic [31:0] a, b;

    always_comb begin
        unique case (sw)
            2'b00: begin 
                // normal positive numbers
                a = 32'd7;
                b = 32'd3;
            end
            2'b01: begin 
                // make subtraction go negative (tests n flag, overflow behavior)
                a = 32'd3;
                b = 32'd7;
            end
            2'b10: begin 
                // big values to trigger carry/overflow in add
                a = 32'h7FFFFFFF; // largest positive signed 32-bit
                b = 32'd1;
            end
            2'b11: begin 
                // equality & zero result (tests z flag)
                a = 32'd9;
                b = 32'd9;
            end
            default: begin
                a = 32'd0;
                b = 32'd0;
            end
        endcase
    end

    // ALU outputs
    logic [31:0] res;
    logic z, n, c, v;

    // your ALU module here
    CPU_alu dut (
        .sel(sel),
        .a(a),
        .b(b),
        .res(res),
        .z(z),
        .n(n),
        .c(c),
        .v(v)
    );

    // Show flags on LEDs.
    // We'll map them from MSB to LSB to keep it obvious:
    // led[3] = v (overflow)
    // led[2] = c (carry/borrow)
    // led[1] = n (negative)
    // led[0] = z (zero)
    assign led[0] = v;
    assign led[1] = c;
    assign led[2] = n;
    assign led[3] = z;

endmodule