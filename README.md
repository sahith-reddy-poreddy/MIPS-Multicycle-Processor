# MIPS Multicycle Processor

This repository contains the Verilog implementation of a MIPS processor based on a multicycle architecture. The processor executes MIPS instructions over multiple clock cycles, dividing tasks like instruction fetch, decode, execution, memory access, and write-back into distinct phases. This design approach optimizes resource usage by reusing hardware components across cycles.

## Features
- **Multicycle Architecture**:
  - Executes instructions across multiple clock cycles for efficient resource utilization.
  - Separate states for instruction fetch, decode, execute, memory access, and write-back.

- **Instruction Set**:
  - Supports a subset of MIPS instructions, including arithmetic, logical, immediate, memory access, and branch operations.

- **Control Unit**:
  - Implements a finite state machine to generate control signals for each instruction phase.

- **ALU (Arithmetic Logic Unit)**:
  - Performs arithmetic and logical operations like addition, subtraction, bitwise AND/OR, and comparisons.
  - Outputs the result and a zero flag for branch decisions.

- **Register File**:
  - 32 general-purpose registers.
  - Supports simultaneous read and write operations.

- **Instruction Memory**:
  - Stores 32-bit MIPS instructions for execution.
  - Provides dynamic read/write capability for simulation.

- **Testbench**:
  - Simulates the processor behavior with test scenarios to validate functionality.

## Project Structure
The project files are organized as follows:
- **`instructions.v`**: Module for instruction memory, including initial program loading.
- **`registerfile.v`**: Module for the register file with read/write capabilities.
- **`processor.v`**: Top-level module that integrates all components and implements the multicycle execution.
- **`control.v`**: Finite State Machine (FSM) for control signal generation based on the instruction type.
- **`ALU_logic.v`**: Arithmetic Logic Unit for performing core computations.
- **`processor_tb.v`**: Testbench to simulate and validate the processor design.

## How to Run
1. Install a Verilog simulation tool such as ModelSim or Xilinx Vivado.
2. Compile the Verilog files in the following order:
   - `instructions.v`
   - `registerfile.v`
   - `control.v`
   - `ALU_logic.v`
   - `processor.v`
   - `processor_tb.v`
3. Run the testbench (`processor_tb.v`) to simulate the MIPS processor.
4. Examine the waveforms and outputs to verify instruction execution across multiple cycles.

## Supported Instructions
- **Arithmetic**: `add`, `addi`, `sub`
- **Logical**: `and`, `or`
- **Memory Access**: `lw`, `sw`
- **Branching**: `beq`

### Additional Instruction: `addi`
The `addi` instruction performs addition with an immediate value:
- **Format**: `addi $rt, $rs, imm`
- **Operation**: `$rt = $rs + imm`
- The immediate value is sign-extended and added to the value in the source register.

## Design Overview
### Multicycle Phases:
1. **Instruction Fetch**:
   - Fetches the instruction from memory.
   - Updates the program counter (PC).

2. **Instruction Decode**:
   - Decodes the fetched instruction.
   - Reads source registers from the register file.

3. **Execution**:
   - Performs arithmetic/logical operations or computes memory addresses using the ALU.

4. **Memory Access**:
   - Reads data from or writes data to memory for `lw`/`sw` instructions.

5. **Write-back**:
   - Writes the result back to the destination register.

### Control Unit:
- Implements a finite state machine to manage the processor's state transitions.
- Generates control signals based on the opcode and function fields of the instruction.

## Future Enhancements
- Extend the instruction set to include advanced operations like multiplication and division.
- Implement pipelined MIPS architecture for performance optimization.
- Add hazard detection and forwarding logic.
- Develop more comprehensive test cases for edge conditions.

## Author
This project demonstrates the implementation of a MIPS multicycle processor using Verilog HDL. Contributions are welcome for further improvements and enhancements.

## License
This project is licensed under the MIT License. See the `LICENSE` file for more details.
