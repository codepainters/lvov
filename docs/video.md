# Video generator

Note:

* all video timing generation is based on `T[..]` signals from timing block
* additionally, `T_RST1` and `T_RST2` signals act as horizontal and vertical blanking, respectively
  * `T_RST1` is low for 256 horizontal pixels, it then goes 1 for 64 pixel times
  * `T_RST2` is low for 256 lines, it then goes high for 64 line periods
* `PB[0..7]` from `PIO` block is used to control color palette (see below)
* data is pulled directly from RAM data outputs - `RD[0..7]` bus

### Synchronization signals generator

Horizontal synchronization pulse:

* is generated using `D38C` NAND gate (used as inverter) and `D44A` 4-input NAND gate
* pulse is active when `T[7] == 0 && T[6] == 1 && T_RST1 == 1`
* given that `T_RST1` is high for `T[10..4] == 100_xxxx`, sync pulse is high when `T[10..4] == 100_01xx`
* i.e. it goes high for `T[10..4]` in range 68..71, giving 4 cycles / 1.25 MHz = 3.2 μs width pulse

Vertical synchronization pulses:

* is generated using `D41A` NAND gate (used as inverter) and `D44B` 4-input NAND gate

* pulse is active when `T[9] == 1 && T[15] == 1 && T[16] == 0 && T_RST2 == 1`

* given that `T_RST2` is high for `T[19..11] == 1_00xx_xxxx`, sync pulse is high when `T[19..11] == 1_0001_xxxx`and `T[9] == 1`

  * 16 pulses are generated for equivalent of 16 scan lines - 16 * 1/15625 Hz = 1024 μs 
  * for each scan line period `T[9]` is low for 32 clocks of modulo 80 counter, then high for 32 cycles and low again for 16 cycles. 
  * this gives 32 / 1.25 MHz = 25.6 μs low,  then 25.6 μs high, then 12.8 μs low
  





