# CPU block

CPU block is a typical 8080 application:

* `D6` - CPU (`8080`)
* `D4` - clock generator and reset signal generator (`8224`)
* `D8` - data bus buffer / control signal latch (`8228`)

* `D2` and `D3` - address bus buffers (`8286`) - these buffers, controlled by `HLDA` signal, allow for DMA operation (not used by on-board hardware, exclusive bus access can be requested by external hardware connected to X1 connector, however).



Note:

* most signals are TTL level, but clock signals `Φ1` and `Φ2` go above 5V level.

* `D5B` flip-flop is used to synchronize CPU and RAM cycles

  * `~STSTB` goes low at the beginning of each CPU cycle, when CPU status is available on the data bus

  *  `ROM_OE` is high for EPROM access, as well as PIO I/O requests, thus `Q` output goes low for RAM access only

  * this in turn causes `READY` line to go low for each RAM request, CPU executes wait states

  * once RAM cycle is completed (see RAM controller description), `VIDEO_CPU` signal is pulsed low, `READY` goes high and CPU completes the RAM read/write cycle.

    

# PIO block

PIO block is a regular 8255 chip application.

* `D28` demux (`74155`) generates chip select signals:
  * `~CS0` (addresses `0xC0..CF`) selects `D30` PIO chip
  * `~CS1` (addresses `0xD0..DF`) selects second `8255` chip on the keyboard PCB
  * `~CS2` (addresses `0xE0..EF`) and `~CS3` (addresses `0xF0..FF`) signals are routed to `X1` connector (not used otherwise). 
* a little trick is used in the address decoder:
  * `~ROM_OE` goes low when `A15` and `A14` lines are high
  * however, during I/O cycles, 8080 CPU outputs 8-bit I/O address on both lower and higher byte of the address buss
  * it's therefore equivalent to decoding `A7` and `A6` lines, without any extra gates - neat! 

