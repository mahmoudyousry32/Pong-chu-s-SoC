# Pong Chu's FPro SoC
This repo contains all the necessary files to build a simple version of Pong chu's Fpro system without the video subsystem from chu's "FPGA Prototyping by SystemVerilog Examples"
## Overview
![chu_mcs](https://github.com/user-attachments/assets/135f0d06-2938-4722-a4ad-17820cc29f32)

## Construction 
it consists of 3 main subsystems the Microblaze microcontroller system , the bridge (signal wrapper) , The MMIO Subsystem 
### MicroBlaze MCS 
MicroBlaze MCS is a complete computer system that is composed of a pre-configured MicroBlaze processor, a RAM constructed with FPGA’s internal memory, and an I/O module with a standard set of microcontroller peripherals. MicroBlaze MCS provides only a limited degree of configurability. A user can set the size of RAM (between 8 KB and 128 KB) and select a small set of simple I/O peripherals.
![1443560624138](https://github.com/user-attachments/assets/8e7189b1-4b9a-444e-bc4f-9ab2d1a29994)

For more info on the microblaze mcs you can check xilinix product guide [PG116](https://docs.amd.com/v/u/en-US/pg116-microblaze-mcs)"
### The Bridge
its just a simple signal wrapper that wraps the signals from the IO Module to the MMIO Subsystem The processor needs to communicate with other cores. This is done by a bus or interconnect structure specified in the vendor’s IP platform. we define a simple synchronous bus protocol FPro bus. The FPro bridge converts vendor’s native bus signals into FPro bus signals. 
### MMIO Subsystem
In the memory-mapped-I/O scheme, the memory and registers of the I/O peripherals are mapped to the same address space. This means that the processor makes no distinction between the memory and I/O peripherals and uses the same read and write instructions to access the I/O peripherals.The MMIO subsystem provides a framework to accommodate memory-mapped general-purpose and special I/O peripherals as well as hardware accelerators. For simplicity, we define a standard slot interface that conforms to the FPro bus protocol. The MMIO subsystem consists of a controller to select a specific slot and can accommodate up to 64 instantiated cores. After being “wrapped” with an interface circuit, custom digital logic can be plugged into the FPro platform.
### Custom IO Modules
I have built a number of custom IO Modules from scratch and integrated them into the MMIO subsystem , A 32 bit timer , a General purpose I/O registers to interface with the onboard LEDs and Switches in the Arty S7-25 board , A 4 Channel 8 bit PWM core with configurable duty cycle and switching frequency , A UART core with configurable baudrate (number of parity and stop bits can be modified in the parameters of the UART core verilog file),A Direct digital frequency synthesizer that is used to generate a Sin wave using pulse desnse modulation with configurable frequency , an SPI , PS2, and I2C core are built but i havent yet integrated them into the MMIO subsystem 
