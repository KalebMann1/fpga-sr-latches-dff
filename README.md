# FPGA Latches & D Flip-Flop (Verilog)

This mini-project implements basic sequential building blocks in Verilog:
an **asynchronous SR latch**, a **gated SR latch**, and a **positive-edge-triggered D flip-flop**.
It’s based on an FPGA lab where the circuits were modeled, simulated, and then mapped to a
Basys-class development board using Vivado.

---

## Project Goals

- Model fundamental memory elements used in digital systems.
- Compare **asynchronous** vs **synchronous** behavior.
- Verify correct operation with a shared Verilog **testbench**.
- Provide simple, readable examples suitable for teaching or reuse in larger designs.

---

## Modules

### `sr_latch_async.v`
Asynchronous SR latch using cross-coupled NAND gates.

- Inputs: `S` (set), `R` (reset) — active high.
- Outputs: `Q`, `Q_bar`.
- Demonstrates:
  - Bistable behavior (two stable states).
  - Set / reset control without a clock.
  - The invalid condition when `S = R = 1`.

### `gated_sr_latch.v`
SR latch with an **enable** input.

- Inputs: `S`, `R`, `EN`.
- Outputs: `Q`, `Q_bar`.
- Latch only responds to `S`/`R` when `EN = 1`; otherwise it holds its state.
- Models how control logic can selectively allow state updates.

### `dff_sync.v`
Positive-edge-triggered D flip-flop with asynchronous reset.

- Inputs: `clk`, `reset` (active high), `D`.
- Output: `Q`.
- On `posedge clk`, `Q` follows `D` unless `reset` is asserted.
- Shows the difference between level-sensitive latches and edge-triggered flip-flops.

---

## Testbench

### `tb_latches.v`

Drives all three modules in one simulation:

- Generates a 10 ns period clock for the DFF.
- Applies sequences of `S`, `R`, and `EN` to:
  - Show set, reset, hold, and invalid SR states.
  - Show how the gated SR latch ignores inputs when `EN = 0`.
- Drives `D` and `reset` to exercise the D flip-flop’s:
  - Normal data capture on rising edges.
  - Asynchronous reset behavior.

This testbench can be simulated in Vivado, ModelSim, or any Verilog simulator.

---

## How to Run (Example Flow in Vivado)

1. Create a new **RTL project**.
2. Add the files from the `src/` directory as design sources.
3. Add `tb_latches.v` from `sim/` as a simulation source.
4. Set `tb_latches` as the top module for simulation.
5. Run behavioral simulation and inspect waveforms for:
   - SR latch set/reset/invalid behavior.
   - Gated SR latch enable behavior.
   - DFF capturing `D` on rising clock edges and responding to `reset`.

---

## Skills Demonstrated

- Verilog RTL coding for basic sequential logic.
- Understanding of:
  - Asynchronous vs synchronous storage elements.
  - Enable gating and invalid SR latch conditions.
- Writing reusable **testbenches** to validate digital designs.
- Preparation for mapping logic to an FPGA using tools such as Vivado.

