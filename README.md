# Designing a Custom AXI Master using Bus Functional Models

A guide to creating custom AXI4 masters using the Xilinx Vivado tools and Bus Functional Models 

----------
This is an application note designed to help users who wish to design their own custom AXI4 Master IPs in Xilinx embedded processor systems.

This version of the application note was written for the [Xilinx Zynq-7000 devices](http://www.xilinx.com/products/silicon-devices/soc/zynq-7000/silicon-devices.html), using the [Avnet MicroZed Board](http://www.microzed.org).  This information is equally applicable to other Xilinx boards and architectures where the AXI4 interconnect is used.

The provided example design was written for the [Xilinx Vivado tools](http://www.xilinx.com/support/download.html).

**Included with this document:**

- Fully commented source code for an example Custom AXI Master
	- Burst support (up to 256 beats)
	- 32 bit and 64 bit data width support
	- Modular implementation of the five AXI4 channels
- Simulation Test benches
	- Test benches for each AXI4 channel
	- Test benches for the entire system
- Example C software code for initiating a Custom AXI4 Master transaction from the Cortex A9 APU
- Example HDL design for controlling the Custom AXI4 Master


----------
## Contributions ##
Code examples are provided for your use, but please feel free to contribute your own code back to this repository via a pull request in the usual fashion.  Please fork from this repo, then create a suitably named branch in your fork before submitting back to this repo.  Please don't submit a pull request from your "master" branch.  Each new addition to the code should belong to its own submitted branch.  Thanks. 

