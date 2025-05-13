# Round-Robin Arbiter (4-Input) – Verilog Implementation

This repository contains the Verilog source code, testbench, and waveform analysis for a 4-input **Round-Robin Arbiter (Fixed Time Slice and Variable Time Slice)**. The design ensures fair arbitration among competing requests by granting access in a rotating priority order.

## 🔧 Features

* **4 request inputs** (`REQ[3:0]`)
* **4 grant outputs** (`GNT[3:0]`)
* Clock and reset based FSM
* Implements fair round-robin arbitration logic
* Supports multiple simultaneous requests
* Fixed Time Slice and Variable Time Slice arbitration logic
* Testbenches and waveform analysis for both implementations

## 🧠 How It Works

The arbiter maintains a pointer to the last granted request. On every clock edge (when reset is low), it checks the request lines starting from the next request cyclically. The grant is given to the first asserted request in this order.

Example behavior with all requests active:

```
Cycle:      0   1   2   3   4
REQ:       1111 1111 1111 1111 1111
GNT:       0001 0010 0100 1000 0001
```

## 📁 Repository Structure

```
.
├── src/
│   └── design.v         # RTL Verilog code for fixed time slice
│   └── design_vts.v     # RTL Verilog code for variable time slice
├── tb/
│   └── tb.v      # Testbench code for fixed time slice
│   └── tb_vts.v  # Testbench code for variable time slice
├── output/
│   └── waveform.png      # Sample waveform screenshot for fixed time slice
│   └── waveform 2.png    # Sample waveform screenshot for variable time slice
│   └── yosys circuit diagram 1.png    # Circuit diagram screenshot for fixed time slice
│   └── yosys circuit diagram.png      # Circuit diagram screenshot for variable time slice
└── README.md             # This file
```

## 🛠 Tools Used

* [EDA Playground](https://www.edaplayground.com) – Functional simulation (Icarus Verilog)
* [Yosys](https://yosyshq.net/yosys/) – Synthesis and RTL analysis
* Aldec Riviera – Waveform analysis

## 🚀 Getting Started

### Simulation (EDA Playground)

> You can view and simulate the design here:
> 🔗 [EDA Playground Link for Fixed Time Slices](https://www.edaplayground.com/x/9Jdd)
> 🔗 [EDA Playground Link for Variable Time Slices](https://www.edaplayground.com/x/GJFg)


## 📌 License

This project is licensed under the MIT License — feel free to use, modify, and distribute.

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

---

*Created with ❤️ by Krishna Chaithanya Therala*
