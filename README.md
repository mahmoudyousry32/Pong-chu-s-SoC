# Pong Chu's SoC
This repo contains all the necessary files to build a simple version of Pong chu's Fpro system without the video subsystem from chu's "FPGA Prototyping by SystemVerilog Examples"
## Overview
![chu_mcs](https://github.com/user-attachments/assets/135f0d06-2938-4722-a4ad-17820cc29f32)

## Construction 
it consists of 3 main subsystems the Microblaze microcontroller system , the bridge (signal wrapper) , The MMIO Subsystem 
### MicroBlaze MCS 
MicroBlaze MCS is delivered as a pre-configured system that includes the MicroBlaze 32-bit RISC soft-processor,local memory access, a coupled IO module, and a standard set of microcontroller peripherals. Through an easy-to-use graphical interface users can configure MicroBlaze MCS for optimum performance in the smallest possible footprint.
![1443560624138](https://github.com/user-attachments/assets/8e7189b1-4b9a-444e-bc4f-9ab2d1a29994)

For more info on the microblaze mcs you can check xilinix product guide [PG116](https://docs.amd.com/v/u/en-US/pg116-microblaze-mcs)"
### The Bridge
its just a simple signal wrapper that wraps the signals from the IO Module to the MMIO Subsystem 
### MMIO Subsystem
The MMIO Subsystem consists of the MMIO controller unit and the custom IO external modules the MMIO controller decodes address signal and routes the data and read and write strobes to the appropriate module based on the address coming from the bridge 


