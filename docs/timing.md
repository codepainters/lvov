# Timing block

The timing block consist of  3 cascaded counters, driven by `OSC` 20 MHz clock. 

### Modulo 16 counter

* uses a single `74LS193` counter (`D34`)

* it overflows with 20 / 16 = 1.25 MHz frequency

* it drives signals `t[0..3]`, which:
  * control RAM access timing
    * when `T[3] == 0` video controller reads a next byte (4 pixels) to be displayed
    * when `T[3] == 1` CPU can issue a RAM read/write
  * control pixel shift register in the video block

### Modulo 80 counter

* uses `74LS193` counter (`D35`) and `74LS93` counter (`D36`) cascade
* drives `T[4..10]` signals, which:
  * provide part of RAM address for the video generator
  * are used to generate horizontal synchronization signal in the video block
* modulo counting is done in a somewhat peculiar way:
  * `D37C` AND gate output (`T_RST1` signal) goes high when counter gets to 64 (`T[10..4] == 100_0000`)
  * when it reaches 80 (`101_0000`), `D37C` output goes low
  * this triggers `D43A` monostable multivibrator, which outputs short (~500-600 ns) pulse, resetting the counter
* `D37C` output (`T_RST1` signal) is also used by the video block (it is high for counts in `64..79` range), i.e. 16 cycles of `T[3]` which gives `12.8 µs`
* this counter block overflows with 15625 Hz frequency (which happens to be the horizontal deflection frequency)

### Modulo 320 counter

* uses `74LS93` counters (`D39` and `D40`), followed by `7474` flip-flop (`D45A`)
* drives `T[11..19]`signals (used as part of RAM address in the video block, and to generate vertical sync pulses)
* modulo counting is done in the same manner as in modulo 80 counter block
* `D37D` output (`T_RST2` signal) goes high when `T[19..11]` is `1_0000_0000` and goes back low when `1_0100_0000` is reached, triggering reset, the pulse width is `64 * 1/15625 Hz = 4.096 ms`
* this counter wraps every 15625 / 320 = ~48.82 Hz (which is the screen refresh rate) 

### Counter synchronization

Note: reset signals from both `74123` multivibrators (i.e. `D43A` and `D43B`) are combined using `D38B` NAND gate, combined signal is sued to reset modulo 80 counter.  My understanding is that this is for modulo 80 counter to start in sync with  modulo 320 counter. 
