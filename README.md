# Zynq Z7 Lite LED Controller (SystemVerilog)

A module written in SystemVerilog for Zynq-7010. It implements two-button input processing with synchronization to clock, debouncing, short/long press detection, and two operating modes (Hold/Toggle) with mode-switch feedback.

## Features & Architecture
* **`debouncer.sv`**: 2-stage flip-flop synchronizer for asynchronous button inputs followed by a debouncer
* **`counter.sv`**: Parameterized long-press threshold detector
* **`mode.sv`**: Dual-button hold detector to detect mode switches
* **`blinker.sv` & `rapid.sv`**: Parameterized clock dividers for LED blinking
* **`top.sv`**: Top-level integration

## What Would I Change Today
This repository represents my very first SystemVerilog project, written before I learned formal Finite State Machine (FSM) design and RTL verification best practices, and basically anything RTL design related. I have kept the original code mostly intact as a baseline (I had to fix one or two very annoying mistakes), with the following architectural improvements noted for the future:

1. **Replace Nested Control Logic with an FSM (`top.sv`):**
   * *Issue:* Mode transitions, button edge detection, and output multiplexing are handled in a single nested `always_ff` block in `top.sv` leaving several unused flags and an unreadable code.
   * *Fix:* Implement a dedicated FSM in for example `controller.sv` with (`HOLD_MODE`, `MODE_TRANSITION`, `TOGGLE_MODE`) states and an edge detector module.
2. **Adding the Missing Reset Logic:**
   * *Issue:* Flip-flops rely on FPGA bitstream power-on defaults (`0`) rather than synchronous/asynchronous reset inputs (`rst_n`). In a standard RTL simulator, uninitialized registers would propagate `'x'`values.
   * *Fix:* Add an active-low reset (`rst_n`) across all modules to guarantee deterministic startup in both simulation and synthesis on all systems.
3. **Module Reuse via Parameterization (`blinker.sv` vs. `rapid.sv`):**
   * *Issue:* `rapid.sv` duplicates `blinker.sv` with a different `on_off_ms` default
   * *Fix:* Use `blinker #(.on_off_ms(500))` and `blinker #(.on_off_ms(50))` instead.