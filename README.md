# FPGAVision
Altera-Cyclone FPGA based vision processing solution for FRC robots

## Purpose
FPGAVision is intended to be a robust, high-throughput, hardware centric vision processing solution for FRC robotics. It is designed to work as a coprocessor with the NI RIO, directly interfacing with a camera and display screen. Information about dentified vision targets is sent back to the RIO via SPI. Additionally, configuration parameters can be sent over SPI.

## Vision Processing Pipeline
The details of the pipeline are still in development, but the following basic outline is planned:
  - Acquire pixels from camera
  - As pixels are recieved, condense them to be either "target" or "not target" via color thresholding
  - As target pixels are identified, group them with an existing blob or start a new blob
  - Merge found blobs together, tracking crucial quantities such as XY location, width, height, area, etc.
  - Make blob information available over SPI interface

## Project Status
FPGAVision is currently in development. All releases as of now are tested, but considered "alpha". 

## Hardware used
  - FPGA Cyclone Altera FPGA EP1C3T144 Learning Board + USB Blaster JTAG programmer
    - Super cost-effective FPGA development board solution. Low-end, but (hopefully) sufficent. 
    - [link](http://www.ebay.com/itm/FPGA-Cyclone-Altera-FPGA-EP1C3T144-Learning-Board-USB-Blaster-JTAG-programmer-/111759847146)
  - OV7670 Camera Module
    - VGA resolution, flexible SCCB camera module
    - [link](http://www.amazon.com/DROK-OV7670-640X480-Interface-Compatible/dp/B00IMYVACI)
  

## Repository Contents
  - root folder - main HDL design files, programmer files, project files.
  - docs/ - Documents on the hardware & algorithms used.

## Required software:
  - Altera Quartus v11.0 (later versions do not support the older Cyclone FPGA used)
  - Altera Quartus Standalone Programmer v15.1 + 

