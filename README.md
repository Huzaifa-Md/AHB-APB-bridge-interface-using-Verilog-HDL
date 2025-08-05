# Design of AMBA-Based AHB to APB Bridge using Verilog HDL

## Overview
This project presents the **design and implementation of an AMBA-based AHB to APB Bridge** using **Verilog HDL**. The bridge acts as a protocol converter, ensuring smooth communication between high-speed **AHB (Advanced High-performance Bus)** and low-speed **APB (Advanced Peripheral Bus)** within a System-on-Chip (SoC) architecture.

The design uses a **Finite State Machine (FSM)** based approach to handle control flow, data buffering, and synchronization between the two protocols, ensuring data integrity and protocol compliance.

---

## Features
- AHB to APB Protocol Translation
- FSM-based APB Controller
- Handshake Signal Management (HREADY, PREADY)
- Support for Single Read, Single Write, and Burst Write Transactions
- Synthesizable Verilog HDL Code
- Waveform Validation and Timing Simulation
- Modular and Scalable Design

---

## AMBA Bus Overview
### AMBA Bus Specifications:
1. **AHB (Advanced High-performance Bus)** — High bandwidth, supports burst transfers.
2. **ASB (Advanced System Bus)** — For systems not requiring high bandwidth.
3. **APB (Advanced Peripheral Bus)** — Low power, simple interface for peripherals.

### AHB to APB Bridge Functionality:
- Acts as an interface between high-speed AHB masters and low-speed APB slaves.
- Translates pipelined AHB transactions into non-pipelined APB transactions.
- Manages clock domain crossing and flow control to ensure data integrity.

---

## Architecture
The AHB2APB Bridge consists of:
1. **AHB Interface Block**: Captures AHB signals like HADDR, HWRITE, HTRANS, etc., and signals FSM for transactions.
2. **FSM Controller**: Manages APB SETUP and ACCESS phases, controlling signal timing and sequencing.
3. **APB Interface Block**: Drives APB control signals (PSEL, PENABLE, PWRITE) and handles data transfers.
4. **Top Module**: Integrates all sub-modules ensuring correct data flow between AHB and APB domains.

---

## Finite State Machine (FSM) States
1. `ST_IDLE`: Idle state, waiting for a valid transfer.
2. `ST_READ`: AHB read phase, preparing for APB read.
3. `ST_RENABLE`: APB read ACCESS phase.
4. `ST_WWAIT`: Wait state to synchronize write.
5. `ST_WRITE`: APB single write transfer.
6. `ST_WENABLE`: Write ENABLE phase.
7. `ST_WRITEP`: Handles multiple pending write transfers.
8. `ST_WENABLEP`: ENABLE phase for multiple writes.

---

## Waveform Scenarios
- **Single Read**: AHB initiates a read; bridge converts it into APB-compliant read sequence.
- **Single Write**: AHB initiates a write; bridge ensures proper APB write transaction.
- **Burst Write**: Handles multiple consecutive writes by converting each AHB beat into a valid APB transaction.

---

## Tools Used
- **Verilog HDL** for RTL design
- **ModelSim/Vivado** for simulation and waveform analysis
- **Synthesis Tools** for RTL verification

---

## How to Run
1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/ahb2apb-bridge.git
    cd ahb2apb-bridge
    ```
2. Open the project in ModelSim/Vivado.
3. Compile Verilog source files.
4. Run simulation testbenches for:
    - Single Read
    - Single Write
    - Burst Write
5. Observe waveform results to verify correct data flow and protocol timing.

---

## Learning Outcomes
- Deep understanding of AMBA AHB/APB protocols.
- Practical experience with FSM design for bus interfaces.
- Hands-on experience in writing synthesizable Verilog code.
- Skills in debugging and verifying hardware designs through simulation.
- Conceptual understanding of data synchronization across clock domains.

---

## Future Enhancements
- Extend support for **AXI Interconnects**.
- Implement **Clock Domain Crossing (CDC)** techniques.
- Optimize for **Low Power Design** considerations.
- Add verification with **UVM testbenches**.

---

## License
This project is licensed under the MIT License.

---

## Author
Md Huzaifa
