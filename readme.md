# Just another OS
# Made for 16bit mode i386

> [!CAUTION]
> This operating system is currently **only tested under QEMU emulation**. It has **NOT been verified on real physical hardware**.  
> **I STRONGLY ADVISE AGAINST ATTEMPTING TO RUN THIS SOFTWARE ON REAL HARDWARE.** Doing so may result in:  
> - System instability or crashes
> - Permanent data loss
> - Hardware damage or failure
> - Bricked devices
>
> If you choose to proceed against this advice, you do so **ENTIRELY AT YOUR OWN RISK**. As stated in the MIT License (which governs this software), the software is provided **"AS IS" WITHOUT WARRANTY OF ANY KIND**, and **the authors shall not be liable** for any damages or losses arising from its use.
> 
> **DO NOT USE ON PRODUCTION SYSTEMS, WITH VALUABLE DATA, OR ON HARDWARE YOU CANNOT AFFORD TO DAMAGE.**
> 
## Licensing  
Based on https://github.com/appusajeev/os-dev-16/  
Some code is from there too  

Copyright (c) 2025 Wdboyes13  
Licensed under the MIT license  
SPDX-License-Identifier: MIT  

## Building 
You'll need these things installed
- nasm
- qemu-system-i386
- make
- mkdir
- echo
- dd
- rm
- clang (if you use another C Compiler edit the "C" variable in the makefile)  

Just do `make run` to run it  
In the OS run `help` to see commands help  
