# Test cases

This directory contains simple assembler programs that I used for diagnosing the machine. 


Note: 

* assemble with https://github.com/Megatokio/zasm
  * I use `zasm` with `--8080` flag (i.e. Z80 syntax, but 8080 instructions only), because I'm much more familiar with Z80 assembler mnemonics. 
  * `make` should just work on Linux

* tests use no stack, no variables in RAM - the idea was to run anything, before being sure RAM works at all.



Tests:

* [01_hello_pio.asm](01_hello_pio.asm) 
  * outputs `0xAA, 0x55, 0xAA, 0x55... ` on PA port of the on-board 8255 
* [02_dump_roms.asm](02_dump_roms.asm)
  * dumps EPROMs address space, i.e. `0xC000..0xFFFF` via `PA` port, `PB2` is used as strobe signal, so it can be captured using a logic analyzer
  * of course, the first EPROM is replaced with the one containing the test code itself
* [03_test_ram.asm](03_test_ram.asm)
  * note: I needed some way to test RAM without actually using it for stack / variables.
  * RAM (all 64kB) is first filled  with a pseudo-random sequence, then it's dumped via `PA` port (`PB2` as strobe, as before)
  * 16-bit [LFSR](https://en.wikipedia.org/wiki/Linear-feedback_shift_register) is used to generate pseudo-random (but deterministic) sequence of bytes, table for LFSR was generated using [pycrc](https://pycrc.org/)
  * Python code in [gen](gen) generates the very same sequence 
  * it can be compared with whatever was captured with logic analyzer to check if RAM operates properly
* [04_video.asm](04_video.asm)
  * generate simple skewed color bars to verify, that the video output works properly

