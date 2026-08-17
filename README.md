# UART Master Controller Using FPGA

## Overview

This project is a UART Master Controller designed using Verilog and implemented on an Artix-7 FPGA.

The main purpose of the project is to send and receive data between an FPGA and an external microcontroller using UART communication.

The project includes the basic parts required for UART communication such as data transmission, data reception, baud rate control, and status signals.

## Features

* UART data transmission
* UART data reception
* 8-bit data transfer
* Configurable baud rate
* Start and stop bit handling
* Transmit and receive status signals
* FPGA-based implementation
* Communication with an STM32 microcontroller
* Verilog-based design
* Simulation and hardware testing using Vivado

## Hardware Used

* Artix-7 FPGA board
* STM32 microcontroller
* USB cable
* Jumper wires

## Software Used

* Xilinx Vivado
* Verilog HDL
* Vivado Simulator
* STM32CubeIDE

## How It Works

The FPGA acts as the UART controller.

When data is given to the controller, it sends the data serially through the UART transmit line.

For receiving data, the controller monitors the UART receive line and collects the incoming bits. After receiving a complete byte, the received data is made available to the rest of the design.

The UART communication follows the standard format:

* 1 start bit
* 8 data bits
* 1 stop bit

For example, when sending one byte, the controller sends the bits one after another instead of sending all 8 bits at the same time.

## Project Structure

```text
UART-Master-Controller/
│
├── rtl/
│   ├── uart_top.v
│   ├── uart_tx.v
│   ├── uart_rx.v
│   └── baud_rate_generator.v
│
├── simulation/
│   └── uart_tb.v
│
├── constraints/
│   └── master.xdc
│
├── docs/
│   └── project_report.pdf
│
└── README.md
```

## Main Modules

### UART Top Module

Connects all the UART parts together and provides the main inputs and outputs of the project.

### UART Transmitter

Takes an 8-bit data value and sends it one bit at a time through the TX line.

### UART Receiver

Receives the serial data from the RX line and converts it back into an 8-bit data value.

### Baud Rate Generator

Generates the timing required for UART communication.

## Simulation

The design was tested using a Verilog testbench in Vivado.

The testbench checks:

* Data transmission
* Data reception
* Start bit
* Data bits
* Stop bit
* Baud rate timing
* Reset operation

## Hardware Testing

After simulation, the design can be programmed onto the Artix-7 FPGA.

The FPGA UART pins are connected to the STM32 UART pins.

The STM32 can be used to send data to the FPGA and receive data back from it.

A serial terminal can also be used to observe the transmitted data.

## Example

If the FPGA is given:

```text
Data = 8'h41
```

The value represents the character:

```text
A
```

The UART transmitter sends this data serially. The receiver can then collect the bits and recover the original value:

```text
8'h41
```

## Learning Outcomes

Through this project, the following concepts are covered:

* UART communication
* Verilog HDL
* Digital logic design
* Counters
* Registers
* Timing control
* Finite state machines
* FPGA implementation
* Verilog simulation
* FPGA pin configuration
* Communication between FPGA and microcontroller

## Future Improvements

The project can be extended by adding:

* Multiple baud rate options
* Parity bit support
* FIFO for storing multiple bytes
* Error detection
* UART command interface
* Communication with multiple devices

## Author

Akash Srivastava

B.Tech Electronics and Communication Engineering
