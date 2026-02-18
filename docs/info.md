<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project implements a simple pseudo-random number generator (RNG) using an LFSR.
On each clock cycle (when enabled), the LFSR shifts and computes a new feedback bit,
producing a changing 8-bit value on `uo_out`.

- `clk`: clock input
- `rst_n`: active-low reset (sets RNG to a non-zero seed)
- `ena`: enable (when low, the state holds)
- `uo_out[7:0]`: current pseudo-random output value

## How to test

Run it

## External hardware

External hardware
