# Fibonacci Calculator (Verilog)

This project implements a **Fibonacci number calculator** using a **finite state machine (FSM)** and a **datapath module** in Verilog. It demonstrates fundamental digital design principles such as control path design, register file management, ALU operations, and state transitions for computing the nth Fibonacci number.

---

## Modules Overview

### 1. `datapath.v`

- Contains registers: A (R0), B (R1), J (R2), N (R3)
- Performs ALU operations: `+`, `-`, `*`, increment, NAND, etc.
- Uses control signals (`asel`, `bsel`, `wsel`, `opsel`, `wen`) to drive multiplexers and enable register writes.
- Outputs:
  - `result`: The calculated Fibonacci number (stored in R0)
  - `z`: Comparison flag used by FSM

### 2. `fsm.v`

- A finite state machine that controls the datapath to compute Fibonacci(n)
- States:
  - `loop_add`: R1 + R0 (F(n) = F(n-1) + F(n-2))
  - `loop_sub`: R1 - R0
  - `loop_j`: Increment index (J = J + 1)
  - `compare`: Check if index == N
  - `done`: Final state
- Outputs control signals to the datapath

### 3. `top_module.v`

- Integrates `datapath` and `fsm` modules
- Exposes input `n`, `clk`, `reset`, and output `result`

### 4. `test_bench.v`

- Drives the top module with:
  - Clock generation
  - Reset pulse
  - Input `n = 6` (computes Fibonacci(6))
- Displays the output in simulation

---

## How It Works

1. **Reset is asserted**
2. Registers are initialized: A = 0, B = 1, J = 0, N = input `n`
3. FSM cycles through states to compute Fibonacci(n)
4. When `J == N`, FSM moves to `done` and result is stored in `R0`

---

## Simulation Example

```verilog
n = 6
Expected Output: Fibonacci(6) = 8
