/*
 * Copyright (c) 2026 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_creditCard (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // design enable: always 1 when the design is powered [cite: 150]
    input  wire       clk,      // clock signal [cite: 149]
    input  wire       rst_n     // reset_n: active low reset [cite: 151]
);

    // 1. Instantiate the Random Number Generator
    // We connect its output directly to the chip's output pins (uo_out) [cite: 153]
    lfsr_rng my_rng (
        .clk      (clk),
        .rst_n    (rst_n),
        .rand_out (uo_out) 
    );

    // 2. Assign unused bidirectional outputs to 0 [cite: 156]
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000; // All bidir pins set as inputs [cite: 157]

    // 3. Prevent synthesis warnings by listing unused inputs [cite: 160]
    // Since we used clk and rst_n, they are removed from this list.
    wire _unused = &{ui_in, uio_in, ena, 1'b0};

endmodule

module lfsr_rng (
    input  wire clk,
    input  wire rst_n,
    output wire [7:0] rand_out
);
    reg [7:0] shift_reg;

    // Feedback logic: XORing specific bits (taps) to create "randomness"
    // For an 8-bit LFSR, taps at bits 8, 6, 5, 4 are standard.
    wire feedback = shift_reg[7] ^ shift_reg[5] ^ shift_reg[4] ^ shift_reg[3];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg <= 8'hFF; // Seed value (cannot be 0)
        end else begin
            shift_reg <= {shift_reg[6:0], feedback};
        end
    end

    assign rand_out = shift_reg;

endmodule
